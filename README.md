# Active Record Lite

## Mimics Active Record’s ORM features.
* Interacts with the database through custom SQL queries.
* Dynamically defines associations using Ruby’s define_method.


## Todo

 * Remove all references of this being a class project
 * Remove everything about phases - filenames (in /lib and /spec) and comments within each file.
 * Remove /lib/00_attr_accessor.rb object. That was a warmup in metaprogramming and it's not actually used in the project
 * Once you remove phases, organize files. Still have multiple files that each monkeypatch or extend SQLObject.
 * Explain in README how somebody would go about using this instead of the real ActiveRecord
 * When you talk about this project, and in your README, don't say that it's a clone of ActiveRecord to understand its functionality. Instead, own it. Say something like, "An ORM inspired by the functionality of ActiveRecord"
  * README:
    * Description/instructions on how to use and run code
    * List of techs/languages/plugins/APIs used
    * Technical implementation details for anything worth mentioning (basically anything you had to stop and think about before building)
      * Include links to the neatest parts of the code
      * Include screenshots of anything that looks pretty
    *future features
  * Go through the whole thing and refactor everything. There will be a lot of obvious things to refactor since you're a much better developer now.
  * Have only 1 class per file - no matter how small the class.
    * Name the files the same as the class (camel_cased).
  * Organize into /lib and /lib/pieces
  * Explain in README how someone would go about downloading and running this.
  
