# README

Play around with jsonapi-rails gem
Examples of requests:
 - index:
  curl -i -H "Accept: application/vnd.api+json" -H 'Content-Type:application/vnd.api+json' -X GET http://localhost:3000/api/v1/stocks
 - create:
  curl -i -H "Accept: application/vnd.api+json" -H 'Content-Type:application/vnd.api+json' -X POST -d '{"data": {"type": "stocks", "attributes": {"name": "My stock" }, "relationships": { "bearer": { "data": { "type": "bearers", "id": "John Smith" }}}}}' http://localhost:3000/api/v1/stocks
 - update:
  curl -i -H "Accept: application/vnd.api+json" -H 'Content-Type:application/vnd.api+json' -X PATCH -d '{"data": {"type": "stocks", "attributes": {"name": "new name" }, "relationships": { "bearer": { "data": { "type": "bearers", "id": "new bearer" }}}}}' http://localhost:3000/api/v1/stocks/1
 - destroy:
  curl -i -H "Accept: application/vnd.api+json" -H 'Content-Type:application/vnd.api+json' -X DELETE http://localhost:3000/api/v1/stocks/1