---
layout: two-cols
---

##### *stylesheet.purs*

```purescript
>>>purs_src<<<
```

::right::

##### *stylesheet.css*

```css
>>>purs_out<<<
```

<mdi-close-box class="text-red-500" /> *@charset* is not the first element <br>
<mdi-close-box class="text-red-500" /> *@charset* element is duplicated <br>
<mdi-close-box class="text-red-500" /> *@import* element is before the *@charset* element <br>
<mdi-close-box class="text-red-500" /> *@namespace* element is before *@import* element <br>
<mdi-close-box class="text-red-500" /> *@namespace* element after style declaration

<!--
* mention breaking every possible rule
-->


