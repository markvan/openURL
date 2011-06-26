isbn
  match
    field = isbn
    pattern = /./
  group = isbn

items_with_title
  match
    field = btitle
    pattern = /./
  match
    field = title
    pattern = /./
  group = institutionResolverID btitle

items_with_title_match
  match
    field = btitle
    pattern = /NATUR/
  group = institutionResolverID btitle

services
  match
    field = sid
    pattern = /./
  group = sid.gsub(/(:|\/).*$/,"")
