# Generic Tagging JSON API

We will be building a Generic Tagging JSON API that can store, retrieve, delete and report on the usage of a "tag" across different entities. This is a guide for the endpoints, if you think you have a better route or would like to modify the naming/schema feel free.

### Create an Entry

```
POST /tag

- Entity Type, e.g. 'Product', 'Article'
- Entity Identifier, e.g. '1234', '582b5530-6cdb-11e4-9803-0800200c9a66'
- Tags, e.g. ['Large', 'Pink', 'Bike']

If the entity already exists it should replace it and all tags, not append to it
```

### Retrieve an Entry

```
GET /tags/:entity_type/:entity_id

- should return a JSON representation of the entity and the tags it has assigned
```

### Remove an Entry

```
DELETE /tags/:entity_type/:entity_id

Completely removes the entity and tags
```

### Retrieve Stats about all Tags

```
GET /stats

Retrieves statistics about all tags

e.g. [{tag: 'Bike', count: 5}, {tag: 'Pink', count: 3}]
```

### Retrieve Stats about a specific Tag

```
GET /stats/:entity_type/:entity_id

Retrieves statistics about a specific tagged entity
```

### Thoughts

So I spent all night working on this and refactoring but I did 'shoot myself in the foot' by not committing all the way
through. Next time for sure! :)

This is my attempt to justify some of my design choices. I've only built one consumption API before this, so making
design choices to be an API that people post to and get from and making certain assumptions was new to me.

I spent a lot of time trying to decide what postgresql data type I should use for storing and searching json data.  Mucked
around with the json data type but was not sufficient because I need to access the array without to much conversion time.
hstore was next up but also seemed like unnecessary conversions. To simplify I just stored the entity_type and entity_id as
strings and storing the array as an array in the DB which sufficed because of the search operators that can be performed on
it. I could also just make the entity_id unique with and index for fast look up, although I probably should try to figure out
how to make it the primary key.

At first I didnt understand how to receive json in the request body so I started out using params to ingest from a form in
some post requests via POSTMAN with raw JSON objects in Chrome. Then I figured out how to use request.body after i got things working using params
for the initial post.

Also, I had some 'weird' validations going on by checking if a new entity was valid according to a uniqueness validation
so if .valid? was true then save the record else lookup the record and update the tags. This was inefficient because I couldn't
get return an error code if presence validation failed. This is where .find_or_initialize_by saved me from that mess because
it does so many things I need in one method. If no record found initialize a new one and insert entity_type and tags else
grab the record if it exists then update the entity_type and tags, so now I could send back a status code if the presence
validation failed for any of the params on the update.

I didn't write any tests because I wasn't sure how to even get this the api started so all tests were done by hand. I can
probably back fill them now that I understand what is going on for this API.

I'm probably missing points on my refactoring but those were the ones that stuck out the most, so will definitely commit
from now on, like I usually do!



