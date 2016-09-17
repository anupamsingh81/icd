# String functions related to regular expression
# Regular expression is a pattern that describes a specific set of strings with a common structure. It is heavily used for string matching / replacing in all programming languages, although specific syntax may differ a bit. It is truly the heart and soul for string operations. In R, many string functions in base R as well as in stringr package use regular expressions, even Rstudio’s search and replace allows regular expression. There are base R commands and stringr package commands to achieve this (indicated with stringr:: below):
#   
#   Identify match to a pattern: grep(..., value = FALSE), stringr::str_detect()
# Extract match to a pattern: grep(..., value = TRUE), stringr::str_extract(), stringr::str_extract_all()
# Locate pattern within a string, i.e. give the start position of matched patterns: regexpr(), gregexpr(), stringr::str_locate(), string::str_locate_all()
# Replace a pattern: gsub(), stringr::str_replace(), stringr::str_replace_all()
# Split a string using a pattern: strsplit(), stringr::str_split()
# Regular expression syntax
# Regular expressions typically specify characters (or character classes) to seek out, possibly with information about repeats and location within the string. This is accomplished with the help of metacharacters that have specific meaning: $ * + . ? [ ] ^ { } | ( ) \. We will use some small examples to introduce regular expression syntax and what these metacharacters mean.
# 
# Escape sequences
# There are some special characters in R that cannot be directly coded in a string. For example, apostrophes. Apostrophes can be used in R to define strings (as well as quotation marks). For example name <- 'Cote d'Ivore'' will return an error. When we want to use an apostrophe as an apostrophe and not a string delimiter, we need to use the “escape” character \'. You would have to “escape” the single quote in the pattern, by preceding it with , so it’s clear it is not part of the string-specifying machinery. So name <- 'Cote d\'Ivore'' will work. Let’s search the country names for those with an apostrophe:
# 
# grep('\'', levels(gDat$country))
# grep('\'', levels(gDat$country), value = TRUE)
# str_detect(levels(gDat$country), '\'')
# str_detect(levels(gDat$country), '\'') %>% levels(gDat$country)[.]
# There are other characters in R that require escaping, and this rule applies to all string functions in R, including regular expressions:
#   
#   \': single quote. You don’t need to escape single quote inside a double-quoted string, so we can also use "'" in the previous example.
# \": double quote. Similarly, double quotes can be used inside a single-quoted string, i.e. '"'.
# \n: newline.
# \r: carriage return.
# \t: tab character.
# Quantifiers
# Quantifiers specify how many repetitions of the pattern.
# 
# *: matches at least 0 times.
# +: matches at least 1 times.
# ?: matches at most 1 times.
# {n}: matches exactly n times.
# {n,}: matches at least n times.
# {n,m}: matches between n and m times.
# Run the following while taking the time to understand the logic:
# 
# strings <- c("a", "ab", "acb", "accb", "acccb", "accccb")
# strings
# grep("ac*b", strings, value = TRUE)
# grep("ac+b", strings, value = TRUE)
# grep("ac?b", strings, value = TRUE)
# grep("ac{2}b", strings, value = TRUE)
# grep("ac{2,}b", strings, value = TRUE)
# grep("ac{2,3}b", strings, value = TRUE)
# stringr::str_extract_all(strings, "ac{2,3}b", simplify = TRUE)
# Exercise
# 
# Using quantifiers find all countries with ee, but not eee, in its name
# 
# Position of pattern within the string
# ^: matches the start of the string.
# $: matches the end of the string.
# \b: matches the empty string at either edge of a word. Don’t confuse it with ^ $ which marks the edge of a string.
# \B: matches the empty string provided it is not at an edge of a word.
# For the last example, \b is not a recognized escape character, so we need to double slash it \\b.
# 
# strings <- c("abcd", "cdab", "cabd", "c abd")
# strings
# grep("ab", strings, value = TRUE)
# grep("^ab", strings, value = TRUE)
# grep("ab$", strings, value = TRUE)
# grep("\\bab", strings, value = TRUE)
# Exercise
# 
# Find the string of country names that
# 
# Start with “South”
# End in “land”
# Have a word in its name that starts with “Ga”
# Character classes
# Character classes allows to – surprise! – specify entire classes of characters, such as numbers, letters, etc. There are two flavors of character classes, one uses [: and :] around a predefined name inside square brackets and the other uses \ and a special character. They are sometimes interchangeable.
# 
# [:digit:] or \d: digits, 0 1 2 3 4 5 6 7 8 9, equivalent to [0-9].
# \D: non-digits, equivalent to [^0-9].
# [:lower:]: lower-case letters, equivalent to [a-z].
# [:upper:]: upper-case letters, equivalent to [A-Z].
# [:alpha:]: alphabetic characters, equivalent to [[:lower:][:upper:]] or [A-z].
# [:alnum:]: alphanumeric characters, equivalent to [[:alpha:][:digit:]] or [A-z0-9].
# \w: word characters, equivalent to [[:alnum:]_] or [A-z0-9_].
# \W: not word, equivalent to [^A-z0-9_].
# [:xdigit:]: hexadecimal digits (base 16), 0 1 2 3 4 5 6 7 8 9 A B C D E F a b c d e f, equivalent to [0-9A-Fa-f].
# [:blank:]: blank characters, i.e. space and tab.
# [:space:]: space characters: tab, newline, vertical tab, form feed, carriage return, space.
# \s: space, ` `.
# \S: not space.
# [:punct:]: punctuation characters, ! " # $ % & ’ ( ) * + , - . / : ; < = > ? @ [  ] ^ _ ` { | } ~.
# [:graph:]: graphical (human readable) characters: equivalent to [[:alnum:][:punct:]].
# [:print:]: printable characters, equivalent to [[:alnum:][:punct:]\\s].
# [:cntrl:]: control characters, like \n or \r, [\x00-\x1F\x7F].
# Note:
# 
# [:...:] has to be used inside square brackets, e.g. [[:digit:]].
# \ itself is a special character that needs escape, e.g. \\d. Do not confuse these regular expressions with R escape sequences such as \t.