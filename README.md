# CEGuideArrow

A custom iOS UI control which allows display of an arrow image to
point at arbitrary locations in a window at arbitrary angles and
lengths.

## Motivation

I created the CEGuideArrow class for an unlaunched side-project in
which I wanted to step through a short tutorial in the app. I needed a
flexible way to guide the user along and point at the next steps along
the work flow. Thus, CEGuideArrow was born, and now I'm giving it to
the world.

## Demo

You can view a quick video demo of the guide arrow at work in the
[CEGuideArrow Demo YouTube
Video](http://www.youtube.com/watch?v=U6sdXCZmmMM).

There is a demo XCode project included with this repo to demonstrate
use of the class.

## Screenshot

![screenshot](https://raw.github.com/jazzychad/CEGuideArrow/master/screenshot.png "screenshot")

## Documentation

There is not much in the way of documentation yet (maybe ever?), but
the demo project demonstrates most of the class's capabilities in
simple code

## What, no ARC?

I'm old school. You can very happily and easily integrate non-ARC code
into ARC projects using the `-fno-objc-arc` flag in the "Compile
Sources" step of the project "Build Phases" - any pull requests or
issues asking to integrate ARC will be rejected with prejudice.

## Contributing

Want to contribute and make CEGuideArrow even better? Great! Send a
pull request my way, and I'll check it out.

Happy Hacking!