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

In your index page, make sure you have a DOM element with ID `infinite`
and render inside of it your initial page content.

At the bottom of your page, add the infinite scrolling loader
by calling the `turbo_scroll_loader` helper and passing the next page index
if a next page is present.

This gem currently assumes that the page parameter is called `page`, so in
your controller make sure you use that parameter for selecting
the records for a given page.

When the loader component becomes visible, it will do 2 things

- append the next page to the #infinite dom id
- update the loader to load the next page (when present)

#### Slim Example

```slim
#infinite
  / render your page fragment here in whatever structure you desire
  / and extract it into a partial or a component to avoid repition, if desired.
  - @articles.each do |article|
    = article

= turbo_scroll_loader(page: @articles.next_page_index)
```

If you want to use a different ID, you'll have to pass it on in turbo_stream response.

### index.turbo_stream.erb|slim

Your turbo_stream response can use the `turbo_scroll_update` helper to
append the next page content and update the current loader with a
loader for the next page.

When using the [next-pageable](https://github.com/allcrux/next-pageable) gem
the next_page_index is already present on the collection when a next page exists.

```slim
= turbo_scroll_update page: @articles.next_page_index
  / render your page fragment here in whatever structure you desire
  / and extract it into a partial or a component to avoid repition, if desired.
  - @articles.each do |article|
    = article
```

### An HTML table alternative for table layouts using CSS grids

As HTML is pretty picky on the tags allowed inside 'table', 'tr', 'td', etc you
can consider using CSS grid as an alternative.

```css
.articles-table {
  display: grid;
  grid-template-columns: minmax(0, 2fr) minmax(0, 2fr) minmax(0, 8fr) minmax(0, 2fr) minmax(0, 1fr) 3em;
  max-width: 100%;
  width: 100%;
}

.articles-table .col {
  height: 2.75rem;
  display: flex;
  align-items: center;
  width: 100%;
  padding-left: 0.5rem;
  padding-right: 0.5rem;
}

.articles-table .col-striped:nth-child(12n+7),
.articles-table .col-striped:nth-child(12n+8),
.articles-table .col-striped:nth-child(12n+9),
.articles-table .col-striped:nth-child(12n+10),
.articles-table .col-striped:nth-child(12n+11),
.articles-table .col-striped:nth-child(12n+12) {
  background-color: #EEEEEE;
}
```

which would go hand in hand with this partial for a record row

```css
.col.col-striped = article.articlenumber
.col.col-striped = article.barcode
.col.col-striped = article.description
.col.col-striped = article.supplier
.col.col-striped.align-right = article.price.print
.col.col-striped.align-right
  a.btn.btn-sm.btn-secondary href=edit_article_path(article)
    i.bi.bi-pencil
```


### Using a different DOM ID

In case you want or need to use a different DOM ID you
can pass it on as an extra param to the `turbo_scroll_update` helper.

The below example illustrates this for the case where your
DOM ID is `#scroll`.

index.html.slim

```slim
#scroll
  - @articles.each do |article|
    = article

= turbo_scroll_loader(page: @articles.next_page_index)
```

index.turbo_stream.slim

```slim
= turbo_scroll_update page: @articles.next_page_index, infinite_dom_id: :scroll
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
