# Others
`Bundle` and `Component` is preferable to be declared as `case` class. Because:
1. It avoid the use of `new` keywords
2. A `case class` provide a `clone` function
3. Construction parameters are directly visible from outside
