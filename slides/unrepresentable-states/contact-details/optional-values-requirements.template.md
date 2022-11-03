---
layout: two-cols
---

```purescript
>>>src<<<
```

::right::

Ambiguity:
* Can e-mail be a string of any characters?
* Can the middle name initial be longer than one character?
* Can the first name be 1 million characters long?
* Can any of these values be empty strings?

Constraints:
* E-mail value should be a well-formed e-mail address.
* The middle name should be 1-character long.
* The first and the last name should not be longer than 50 characters.
* None of these values can be empty string.
