# TurboScroll

TurboScroll is a minimalistic gem that provides infinite scrolling for Rails based applications
using Turbo.

Underlying it depends on ViewComponent and Slim but these are not forced upon the user.

## Usage

### Controller

Make sure your index action responds both to html and turbo_stream

```
    respond_to do |format|
      format.html
      format.turbo_stream
    end
```

### index.html.erb|slim

In your index page, make sure you have a DOM element with ID `infinite`
and render inside of it your initial page content.

At the bottom of your page, add the infinite scrolling loader
by calling the `turbo_scroll_loader` helper and passing the next page index
if a next page is present.

You could use the [next_pageable](https://github.com/allcrux/next_pageable) gem
but one can also use any other pagination gem of choice.

#### Slim Example


```
#infinite
  - @articles.each do |article|
    = article

= turbo_scroll_loader(page: @articles.next_page_index)
```

If you want to use a different ID, you'll have to pass it on in turbo_stream response.

### index.turbo_stream.erb|slim

Your turbo_stream response can use the `turbo_scroll_update` helper to
append the next page content and update the current loader with a
loader for the next page.

When using the [next_pageable](https://github.com/allcrux/next_pageable) gem
the next_page_index is already present on the collection when a next page exists.

```
= turbo_scroll_update page: @articles.next_page_index
  - @articles.each do |article|
    = article
```

### Using a different DOM ID

In case you want or need to use a different DOM ID you
can pass it on as an extra param to the `turbo_scroll_update` helper.

The below example illustrates this for the case where your
DOM ID is `#scroll`.

index.html.slim

```
#scroll
  - @articles.each do |article|
    = article

= turbo_scroll_loader(page: @articles.next_page_index)
```

index.turbo_stream.slim

```
= turbo_scroll_update page: @articles.next_page_index, infinite_dom_id: :scroll
  - @articles.each do |article|
    = article
```



### index.

## Installation
Add this line to your application's Gemfile:

```ruby
gem "turbo-scroll"
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install turbo-scroll
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
