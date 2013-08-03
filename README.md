# Coffee Resque

This is my template that I have come to use over various internal projects at
work.  It has been stripped down to its core and generalized in attempt to make
it as broadly useful as possible.

This template comes prebuilt with jQuery, Twitter Bootstrap, and Backbone.js
included.

## Compiling

All coffeescript needs to be compiled to JS before being executed.  In a
development environemnt, you can accomplish this by:

    cake dev

This will also reload any changes made to your code immediately.

**NOTE:** To recompile client views (i.e., anything in the `views/client`
folder), you must run `cake compile` or `cake build` manually.

This has the side-effect of starting a webserver you can use to view your app.
By default this binds to port 3000, though this can be overriden using the
`PORT` environment variable.

For production uses, you can run the command

    cake build

to build all necessary components of your app.

## Tests

Tests can be run using

    cake spec
    cake test

Either will run the tests.

## Contributing

Standard guidelines apply.  Fork, branch off of master, submit pull request.

Please document as much as possible (within reason) when submitting changes

## Bugs

Bugs can be filed through GitHub's bug tracker.  Every attempt will be made to
answer these in a timely manner, though I cannot guarantee every bug will get
immediate attention.

## Credits

Much of this is custom written, or conceptually based off of other project
encountered.

Here is a (potentially non-exauhstive) list of projects that have influenced
this one, and the sections of this codebased they pertain to:

- http://twilson63.github.com/express-coffee/
  
  The configuration system, as well as the Cakefile

## License

Copyright (C) 2013 Lucas Cycon, Adam Kuipers

All files distributed herein subject to the following license.  Any files marked
individually fall under their included license.

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License,
or
(at your option) any later version.

This program is distributed in the hope that it will be
useful,
but WITHOUT ANY WARRANTY; without even the implied
warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR
PURPOSE.  See the
GNU General Public License for more details.
