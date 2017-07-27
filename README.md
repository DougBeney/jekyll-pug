# Jekyll-Pug

Finally be able to code with [Pug](https://pugjs.org/api/getting-started.html) on [Jekyll](http://github.com/mojombo/jekyll).

Created by [Doug](https://dougbeney.com) of [FloeMedia](https://floemedia.com). This project was forked from samvincent's [jekyll-haml](https://github.com/samvincent/jekyll-haml).

## Table Of Contents

- [Installation](#installation)
- [Usage](#usage)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [Support on Beerpay](#support-on-beerpay)

## Installation

**Note:** you must have [pug-cli](https://www.npmjs.com/package/pug-cli) installed. To install it, simply enter the terminal command, `npm install pug-cli -g`.

There are two ways to install this plugin.

**Way #1**

In your terminal, type `gem install jekyll-pug`.

Then, edit your `_config.yml` and add the following.

```yml
plugins:
    - jekyll-pug
```

You're done!

**Way #2 (Using Bundler)**

If using [Bundler](http://gembundler.com), add the following to your `Gemfile`:

```rb
group :jekyll_plugins do
  gem 'jekyll-pug'
end
```

After that, type `bundle install` in your Terminal.

*If you're having trouble setting up your Gemfile, make sure to include the line `source "https://rubygems.org"` at the top of your Gemfile.*

---

## Usage

You'll be able to create Pug pages, templates, and includes, just like you would with HTML files.

**Important:** Always make sure to have YAML front matter at the top of your pug pages. Layouts and includes don't need this, but plain-old pages do.

**Example:**

```
---
---

h1 Hello World!
```

---

**Practical Example:**

**./index.pug**

```
---
title: Home Page
layout: default
---

p Welcome to my home page. Isn't it awesome?
```

**./_layouts/default.pug**

```
doctype
html
    head
        title {{page.title}}
    body
        h1 {{page.title}}
        | {{content}}
```

---

### Include

Jekyll's `include` tag has been rewritten to support pug. Pug will look in your `_includes` folder.

```
h1 This code will include nav.pug
{% include nav %}
```

You can alternatively type the extension out.

```
h1 This code will include nav.pug
{% include nav.pug %}
```

Have an HTML file you want to include? No problem! Do this:

```
h1 This code will include nav.html
{% include nav.html %}
```

---

### Regular Pug Include (How You Can Use Mixins And Variables)

**Warning:** I only recommend using Pug includes for including a variable or mixin file. For most things you'll want to use Jekyll's `include` tag as mentioned earlier.

Here's an example:

**./index.pug**

```
---
---

include variables
h1 Here is a Pug Variable:
p= my_cool_variable
```

**./_includes/variables.pug**

```
- var my_cool_variable = "Er mer gerd! I'm a variable!";
```

When you run `jekyll build` on the above code, you will get the following output:

```html
<h1>Here is a Pug Variable:</h1>
<p>Er mer gerd! I'm a variable!</p>
```

---

### "Can I use Pug extends?"

I'd highly recommend steering clear from using Pug extends with this plugin. Biggest problem with them is that they will not render Jekyll variables.

If you REALLY want to use them, this plugin looks in the `_includes` folder for extends.

---

## Troubleshooting

### "No such file or directory - pug"

This issue typically means that you do not have the NPM package `pug-cli` installed globally. [Here is the solution](https://github.com/DougBeney/jekyll-pug/issues/3)

**Have an issue that's not listed here?** [Submit a New Issue](https://github.com/DougBeney/jekyll-pug/issues/new)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

**How to create a development environment for contributing to this plugin:**

1. Clone the repo
2. Run the command `bundle` in terminal.
3. CD into the `test-site/` directory.
4. Run `jekyll serve`

**"What code do I modify?"**

The code you should modify is in the `lib/` directory.

- `lib/jekyll-pug.rb` is the render code for regular pages you have in the root directory of your project.
- `lib/tags/pug_partial.rb` is the file that overwrites Jekyll's `include` tag.
- `lib/jekyll-pug/ext/convertible.rb` re-opens the layout class. In most cases you shouldn't have to modify this.

## Support on Beerpay
Hey dude! Help me out for a couple of :beers:!

[![Beerpay](https://beerpay.io/DougBeney/jekyll-pug/badge.svg?style=beer-square)](https://beerpay.io/DougBeney/jekyll-pug)  [![Beerpay](https://beerpay.io/DougBeney/jekyll-pug/make-wish.svg?style=flat-square)](https://beerpay.io/DougBeney/jekyll-pug?focus=wish)
