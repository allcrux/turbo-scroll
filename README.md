[![Gem Version](https://badge.fury.io/rb/turbo-scroll.svg)](https://badge.fury.io/rb/turbo-scroll)

# TurboScroll

TurboScroll is a minimalistic gem that provides infinite scrolling for Rails based applications
using Turbo.

Why a new gem? Leveraging Turbo we can build a very small and efficient implementation
for infinite page scrolling without extra dependencies.

It's made to be independent from your choice of pagination.
You can use the [next-pageable](https://github.com/allcrux/next-pageable) gem, which
is another minimalistic gem for very basic paging leveraging Rails concerns, to just
provide the functionality you need for infinite scrolling and avoiding a count query
on each page request (Your main page might still do a count query but you won't
be repeating them when requesting next page data behind the scenes.)


Underlying it depends on ViewComponent and Slim but these are not forced upon the user.

## Usage

### Controller

Make sure your index action responds both to html and turbo_stream

```rb
@articles = Article.scoped.paginate(params[:page]) # next-pageable

respond_to do |format|
  format.html
  format.turbo_stream
end
```

### index.html.erb|slim

The simplest is to use the `turbo_scroll_auto` helper and
nest inside your initial infinite content. This will wrap the
content with an element with id #infinite that will be
used to append new content to for infinite scrolling.


```slim
= turbo_scroll_auto page: @articles.next_page_index
  - @articles.each do |article|
    = article
```

Alternatively, in your index page, make sure you have a DOM element with ID `infinite`
and render inside of it your initial page content.

At the bottom of your page, add the infinite scrolling loader
by calling the `turbo_scroll_auto` helper and passing the next page index
if a next page is present.

```slim
#infinite
  - @articles.each do |article|
    = article

= turbo_scroll_auto page: @articles.next_page_index
```

This gem currently assumes that the page parameter is called `page`, so in
your controller make sure you use that parameter for selecting
the records for a given page.

When the loader component becomes visible, it will do 2 things

- append the next page to the #infinite dom id
- update the loader to load the next page (when present)

If you want to use a different ID, you'll have to pass it on in turbo_stream response.

### index.turbo_stream.erb|slim

Your turbo_stream response can use the `turbo_scroll_auto_stream` helper to
append the next page content and update the current loader with a
loader for the next page.

When using the [next-pageable](https://github.com/allcrux/next-pageable) gem
the next_page_index is already present on the collection when a next page exists.

```slim
= turbo_scroll_auto_stream page: @articles.next_page_index
  - @articles.each do |article|
    = article
```

### More variant (no auto loading, just simple 'more' loading)

```slim
= turbo_scroll_more page: @articles.next_page_index
  = render(Articles::Row.with_collection(@articles))
```

Your turbo_stream response can use the `turbo_scroll_more_stream` helper to
append the next page content and update the current more loader with a
more loader for the next page.

articles\index.turbo_stream.slim

```slim
= turbo_scroll_more_stream page: @articles.next_page_index
  = render Articles::Row.with_collection(@articles)
```

### An HTML table alternative for table layouts using CSS grids

As HTML is pretty picky on the tags allowed inside 'table', 'tr', 'td', etc you
can consider using CSS grid as an alternative.

```css
.article.row {
  display: grid;
  grid-template-columns: minmax(0, 2fr) minmax(0, 2fr) minmax(0, 8fr) minmax(0, 2fr) minmax(0, 1fr) 3em;
  max-width: 100%;
  width: 100%;
}

.article.row .col {
  height: 2.75rem;
  display: flex;
  align-items: center;
  width: 100%;
  padding-left: 0.5rem;
  padding-right: 0.5rem;
}

.article.row .col-head {
  font-weight: bolder;
}

.article.row .col-filter {
  padding-left: 0rem;
  padding-right: 0rem;
}

.article.row .align-right {
  justify-content: right;
}

.article.row.striped:nth-child(2n+1) {
  background-color: #EEEEEE;
}
```

which would go hand in hand with this partial for a record row

```slim
.article.row.striped
  .col = article.articlenumber
  .col = article.barcode
  .col = article.description
  .col = article.supplier
  .col.align-right = article.price.print
  .col.align-right
    a.btn.btn-sm.btn-secondary href=edit_article_path(article)
      i.bi.bi-pencil
```


### Using a different DOM ID

In case you want or need to use a different DOM ID you
can pass it on as an extra param to the `turbo_scroll_auto_stream` helper.

The below example illustrates this for the case where your
DOM ID is `#scroll`.

index.html.slim

```slim
= turbo_scroll_auto page: @articles.next_page_index, id: :scroll
  - @articles.each do |article|
    = article
```

index.turbo_stream.slim

```slim
= turbo_scroll_auto_stream page: @articles.next_page_index, infinite_dom_id: :scroll
  - @articles.each do |article|
    = article
```

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add turbo-scroll

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install turbo-scroll

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
