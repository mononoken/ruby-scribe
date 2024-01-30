# # Fae Scribe

<!-- ![A screenshot showing a preview of the project.](screenshot.png "Project Preview") -->

[Click here to see a live version!](http://fae-scribe-c77ffba44917.herokuapp.com/dashboard)

This app is for note-taking on your tabletop adventures! Create notes that you can format quickly using [Markdown](https://www.markdownguide.org/cheat-sheet/).

Reference other notes using a custom linking syntax:

```
# Session 1:
[[Galstaff]] cast magic missile at the [[darkness]].
```

With this syntax, if you have notes named "Galstaff" and "darkness", your new note, "Session 1", will automatically generate the correct links to these notes.

If you are interested in seeing features that are being worked on or have suggestions, please see our [issues](https://github.com/mononoken/fae-scribe/issues).

## Table of Contents

<!-- - Install(#install) -->

- [General Information](#general-information)
- [Acknowledgements](#acknowledgements)
- [Resources](#resources)
- [Reporting Issues / Feedback / Contact](#reporting-issuesfeedbackcontact)

<!-- ## Install -->
<!---->
<!-- Include dependencies and how to install and run the program on a local machine. -->

## General Information

This app utilizes [Turbo](https://turbo.hotwired.dev/)'s Turbo Frames to quickly render new notes without the need of reloading. It also supports WebSocket through Turbo Streams so that notes created by other users in your shared collection will automatically load without reloading the page.

Extensive testing is implemented using RSpec and Capybara.

[Tailwind CSS](https://tailwindcss.com/) is used for web styling.

See `Gemfile` to explore other tools used.

## Acknowledgements

- Lucas, my [First Ruby Friend](https://firstrubyfriend.org) mentor. Thank you so much for meeting with me regularly and advising me on my Ruby journey! Your help has been invaluable!
- [The Odin Project](https://www.theodinproject.com), my primary guide in the vast sea of web-development learning.
  - And the Discord community!

## Resources:

- SVGs: https://heroicons.com/

## Reporting Issues/Feedback/Contact

Bug reports are greatly appreciated. You may create a [new issue](https://github.com/mononoken/fae-scribe/issues/new) with a description of the problem, and the steps leading up to it.

You may also contact me at: mail@feelsufo.com
