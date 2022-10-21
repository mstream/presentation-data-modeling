#! /usr/bin/env nix-shell
#! nix-shell -i bash

set -e

function print_before() {
  local pattern="$1"
  awk "/${pattern}/{exit} 1"
}

function print_after() {
  local pattern="$1"
  awk "f;/${pattern}/{f=1}"
}

function print_range() {
  sed -n "${1} p" "${2}"
}

function inject_css() {
  local template_name="$1"
  local src_name="$2"
  local template_file="slides/${template_name}.template.md"
  local generated_file="slides/${template_name}.generated.md"
  local src_file="src/css/${src_name}.css"
  local css_src_pattern='>>>css_src<<<'
  local css_src=$(cat "${src_file}")
  local template=$(cat "${template_file}")

  if [ -z "${template}" ]; then
    echo "the ${template_file} template does not exist"
    exit 1
  fi

  if [ -z "${css_src}" ]; then
    echo "the ${src_file} css source code does not exist"
    exit 1
  fi

  local template_with_src=$(\
    echo -n "${template}" | print_before "${css_src_pattern}";\
    echo "${css_src}";\
    echo -n "${template}" | print_after "${css_src_pattern}"\
  )
  
  echo -n "${template_with_src}" > "${generated_file}"
  echo "${template_file} -> ${generated_file}"
}

function inject_definition() {
  local template_name="$1"
  local src_name="$2"
  local range="$3"
  local template_file="slides/${template_name}.template.md"
  local generated_file="slides/${template_name}.generated.md"
  local src_file="src/purs/${src_name}.purs"
  local purs_src_pattern='>>>purs_src<<<'
  local purs_src=$(print_range "${range}" "${src_file}")
  local template=$(cat "${template_file}")

  if [ -z "${template}" ]; then
    echo "the ${template_file} template does not exist"
    exit 1
  fi

  if [ -z "${purs_src}" ]; then
    echo "the ${src_file} purerscript source code does not exist"
    exit 1
  fi

  local template_with_src=$(\
    echo -n "${template}" | print_before "${purs_src_pattern}";\
    echo "${purs_src}";\
    echo -n "${template}" | print_after "${purs_src_pattern}"\
  )
  
  echo -n "${template_with_src}" > "${generated_file}"
  echo "${template_file} -> ${generated_file}"
}


function inject_executable() {
  local template_name="$1"
  local src_name="$2"
  local module_name="$3"
  local range="$4"
  local module="Main.${module_name}"
  local template_file="slides/${template_name}.template.md"
  local generated_file="slides/${template_name}.generated.md"
  local src_file="src/purs/Main/${src_name}.purs"
  local purs_src_pattern='>>>purs_src<<<'
  local purs_src=$(print_range "${range}" "${src_file}")
  local purs_out_pattern='>>>purs_out<<<'
  local purs_out=$(spago run -m "${module}" 2>/dev/null)
  local template=$(cat "${template_file}")

  if [ -z "${template}" ]; then
    echo "the ${template_file} template does not exist"
    exit 1
  fi

  if [ -z "${purs_src}" ]; then
    echo "the ${src_file} purerscript source code does not exist"
    exit 1
  fi

  if [ -z "${purs_out}" ]; then
    echo "the ${module_name} purerscript module did not produce any output"
  fi

  local template_with_src=$(\
    echo -n "${template}" | print_before "${purs_src_pattern}";\
    echo "${purs_src}";\
    echo -n "${template}" | print_after "${purs_src_pattern}"\
  )

  local template_with_src_and_out=$(\
    echo -n "${template_with_src}" | print_before "${purs_out_pattern}";\
    echo "${purs_out}";\
    echo -n "${template_with_src}" | print_after "${purs_out_pattern}"\
  )
  
  echo -n "${template_with_src_and_out}" > "${generated_file}"
  echo "${template_file} -> ${generated_file}"
}

find slides -iname '*.generated.md' -exec rm {} \; 

inject_css \
  stylesheet/formatted \
  stylesheet

inject_definition \
  mean/array-idea \
  Mean/Array \
  8,8

inject_definition \
  mean/non-empty-array-idea \
  Mean/NonEmptyArray \
  8,11

inject_definition \
  stylesheet/array-idea \
  Stylesheet/Array \
  29,29

inject_definition \
  stylesheet/array-sort-and-validate-idea \
  Stylesheet/Array \
  29,31

inject_definition \
  stylesheet/record-idea \
  Stylesheet/Record \
  27,32

inject_executable \
  mean/array-valid \
  Mean/Array/Valid \
  Mean.Array.Valid \
  12,13

inject_executable \
  mean/array-invalid \
  Mean/Array/Invalid \
  Mean.Array.Invalid \
  12,13

inject_executable \
  mean/non-empty-array \
  Mean/NonEmptyArray \
  Mean.NonEmptyArray \
  12,17

inject_executable \
  stylesheet/array-valid \
  Stylesheet/Array/Valid \
  Stylesheet.Array.Valid \
  20,35

inject_executable \
  stylesheet/array-invalid \
  Stylesheet/Array/Invalid \
  Stylesheet.Array.Invalid \
  20,36

inject_executable \
  stylesheet/array-sort-and-validate-valid \
  Stylesheet/ArraySortAndValidate/Valid \
  Stylesheet.ArraySortAndValidate.Valid \
  24,39

inject_executable \
  stylesheet/array-sort-and-validate-invalid \
  Stylesheet/ArraySortAndValidate/Invalid \
  Stylesheet.ArraySortAndValidate.Invalid \
  24,40

inject_executable \
  stylesheet/record \
  Stylesheet/Record \
  Stylesheet.Record \
  14,35


