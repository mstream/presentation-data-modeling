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

function inject_source() {
  local template_name="$1"
  local src_name="$2"
  local range="$3"
  local template_file="slides/${template_name}.template.md"
  local generated_file="slides/${template_name}.generated.md"
  local src_file="src/${src_name}"
  local src_pattern='>>>src<<<'
  local src=$(print_range "${range}" "${src_file}")
  local template=$(cat "${template_file}")

  if [ -z "${template}" ]; then
    echo "the ${template_file} template does not exist"
    exit 1
  fi

  if [ -z "${src}" ]; then
    echo "the ${src_file} source file does not contain any code"
    exit 1
  fi

  local template_with_src=$(\
    echo -n "${template}" | print_before "${src_pattern}";\
    echo "${src}";\
    echo -n "${template}" | print_after "${src_pattern}"\
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
    echo "!!! the ${module_name} purerscript module did not produce any output"
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
find src/js -iname '*.generated.js' -exec rm {} \; 

npm run uglify \
  --src=src/js/readable-code.js \
  --dst=src/js/unreadable-code.generated.js

inject_source \
  ubiquitous-language/card-game/unreadable-code \
  js/unreadable-code.generated.js \
  '1,$'

inject_source \
  unrepresentable-states/stylesheet/formatted \
  css/stylesheet.css \
  '1,$'

inject_source \
  ubiquitous-language/card-game/model \
  purs/CardGame.purs \
  '21,41'

inject_source \
  ubiquitous-language/card-game/model-card \
  purs/CardGame.purs \
  '21,41'

inject_source \
  ubiquitous-language/card-game/model-suit-and-rank \
  purs/CardGame.purs \
  '21,41'

inject_source \
  ubiquitous-language/card-game/model-deck \
  purs/CardGame.purs \
  '21,41'

inject_source \
  ubiquitous-language/card-game/model-shuffled-deck \
  purs/CardGame.purs \
  '21,41'

inject_source \
  ubiquitous-language/card-game/model-shuffle \
  purs/CardGame.purs \
  '21,41'

inject_source \
  ubiquitous-language/card-game/model-deal \
  purs/CardGame.purs \
  '21,41'

inject_source \
  ubiquitous-language/card-game/model-hand \
  purs/CardGame.purs \
  '21,41'

inject_source \
  ubiquitous-language/card-game/model-pick-up-card \
  purs/CardGame.purs \
  '21,41'

inject_source \
  ubiquitous-language/card-game/model-player-and-game \
  purs/CardGame.purs \
  '21,41'

inject_source \
  ubiquitous-language/diagram \
  dot/ubiquitous-language.dot \
  '1,$'

inject_source \
  ubiquitous-language/card-game/flow-shuffle \
  dot/card-game/flow.dot \
  '6,16'

inject_source \
  ubiquitous-language/card-game/flow-deal \
  dot/card-game/flow.dot \
  '15,29'

inject_source \
  ubiquitous-language/card-game/flow-pick-up-card \
  dot/card-game/flow.dot \
  '28,42'

inject_source \
  ubiquitous-language/card-game/flow \
  dot/card-game/flow.dot \
  '6,42'

inject_source \
  unrepresentable-states/contact-details/weak-model \
  purs/ContactDetails/WeakModel.purs \
  '3,9'

inject_source \
  unrepresentable-states/contact-details/weak-model-requirements \
  purs/ContactDetails/WeakModel.purs \
  '3,9'

inject_source \
  unrepresentable-states/contact-details/consistency-boundaries \
  purs/ContactDetails/ConsistencyBoundaries.purs \
  '7,25'

inject_source \
  unrepresentable-states/contact-details/consistency-boundaries-requirements \
  purs/ContactDetails/ConsistencyBoundaries.purs \
  '7,25'

inject_source \
  unrepresentable-states/contact-details/optional-values \
  purs/ContactDetails/OptionalValues.purs \
  '9,23'

inject_source \
  unrepresentable-states/contact-details/optional-values-requirements \
  purs/ContactDetails/OptionalValues.purs \
  '9,23'

inject_source \
  unrepresentable-states/contact-details/refined-strings \
  purs/ContactDetails/RefinedStrings.purs \
  '13,34'

inject_source \
  unrepresentable-states/contact-details/refined-strings-requirements \
  purs/ContactDetails/RefinedStrings.purs \
  '13,34'

inject_source \
  unrepresentable-states/contact-details/discriminated-union \
  purs/ContactDetails/DiscriminatedUnion.purs \
  '15,41'

inject_source \
  unrepresentable-states/contact-details/real-name-and-nickname \
  purs/ContactDetails/RealNameAndNickname.purs \
  '16,27'

inject_source \
  unrepresentable-states/contact-details/real-name-and-nickname-optional \
  purs/ContactDetails/RealNameAndNicknameOptional.purs \
  '16,20'

inject_source \
  unrepresentable-states/contact-details/real-name-and-nickname-alternative \
  purs/ContactDetails/RealNameAndNicknameAlternative.purs \
  '16,19'

inject_source \
  unrepresentable-states/contact-details/real-name-and-nickname-union \
  purs/ContactDetails/RealNameAndNicknameUnion.purs \
  '16,25'

inject_source \
  unrepresentable-states/mean/array-idea \
  purs/Mean/Array.purs \
  '8,8'

inject_source \
  unrepresentable-states/mean/non-empty-array-idea \
  purs/Mean/NonEmptyArray.purs \
  '8,11'

inject_source \
  unrepresentable-states/stylesheet/array-idea \
  purs/Stylesheet/Array.purs \
  '29,29'

inject_source \
  unrepresentable-states/stylesheet/array-sort-and-validate-idea \
  purs/Stylesheet/Array.purs \
  '29,31'

inject_source \
  unrepresentable-states/stylesheet/record-idea \
  purs/Stylesheet/Record.purs \
  '27,32'

inject_source \
  unrepresentable-states/survey/prompts-and-responses-idea \
  purs/Survey/PromptsAndResponses.purs \
  '6,9'

inject_source \
  unrepresentable-states/survey/prompt-and-response-pairs-idea \
  purs/Survey/PromptAndResponsePairs.purs \
  '6,11'

inject_source \
  unrepresentable-states/survey/question-index-idea \
  purs/Survey/QuestionIndex.purs \
  '5,8'

inject_source \
  unrepresentable-states/survey/current-question-idea \
  purs/Survey/CurrentQuestion.purs \
  '5,8'

inject_source \
  unrepresentable-states/survey/previous-and-next-questions-idea \
  purs/Survey/PreviousAndNextQuestions.purs \
  '5,9'

inject_executable \
  unrepresentable-states/mean/array-valid \
  Mean/Array/Valid \
  Mean.Array.Valid \
  '12,13'

inject_executable \
  unrepresentable-states/mean/array-invalid \
  Mean/Array/Invalid \
  Mean.Array.Invalid \
  '12,13'

inject_executable \
  unrepresentable-states/mean/non-empty-array \
  Mean/NonEmptyArray \
  Mean.NonEmptyArray \
  '12,17'

inject_executable \
  unrepresentable-states/stylesheet/array-valid \
  Stylesheet/Array/Valid \
  Stylesheet.Array.Valid \
  '20,35'

inject_executable \
  unrepresentable-states/stylesheet/array-invalid \
  Stylesheet/Array/Invalid \
  Stylesheet.Array.Invalid \
  '20,36'

inject_executable \
  unrepresentable-states/stylesheet/array-sort-and-validate-valid \
  Stylesheet/ArraySortAndValidate/Valid \
  Stylesheet.ArraySortAndValidate.Valid \
  '24,39'

inject_executable \
  unrepresentable-states/stylesheet/array-sort-and-validate-invalid \
  Stylesheet/ArraySortAndValidate/Invalid \
  Stylesheet.ArraySortAndValidate.Invalid \
  '24,40'

inject_executable \
  unrepresentable-states/stylesheet/record \
  Stylesheet/Record \
  Stylesheet.Record \
  '14,35'

inject_executable \
  unrepresentable-states/survey/prompts-and-responses-valid \
  Survey/PromptsAndResponses/Valid \
  Survey.PromptsAndResponses.Valid \
  '15,27'

inject_executable \
  unrepresentable-states/survey/prompts-and-responses-invalid \
  Survey/PromptsAndResponses/Invalid \
  Survey.PromptsAndResponses.Invalid \
  '15,19'

inject_executable \
  unrepresentable-states/survey/prompt-and-response-pairs \
  Survey/PromptAndResponsePairs \
  Survey.PromptAndResponsePairs \
  '15,20'

inject_executable \
  unrepresentable-states/survey/question-index-valid \
  Survey/QuestionIndex/Valid \
  Survey.QuestionIndex.Valid \
  '15,23'

inject_executable \
  unrepresentable-states/survey/question-index-invalid \
  Survey/QuestionIndex/Invalid \
  Survey.QuestionIndex.Invalid \
  '15,23'

inject_executable \
  unrepresentable-states/survey/current-question-valid \
  Survey/CurrentQuestion/Valid \
  Survey.CurrentQuestion.Valid \
  '15,23'

inject_executable \
  unrepresentable-states/survey/current-question-invalid \
  Survey/CurrentQuestion/Invalid \
  Survey.CurrentQuestion.Invalid \
  '15,23'

inject_executable \
  unrepresentable-states/survey/previous-and-next-questions \
  Survey/PreviousAndNextQuestions \
  Survey.PreviousAndNextQuestions \
  '15,20'


