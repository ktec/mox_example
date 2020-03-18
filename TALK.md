# Scalable software patterns with Monads

This project provides a contrived example of when using Mox can make things
difficult. Besides being difficult to test, this approach to writing software
also suffers from scalability.

Let's walk through a simple example:

You have some code which depends on external services, let's imagine you need
to make an http request which consumes some data, processes that data and
writes to a cache. Once the cache has been updated the service then connects
to an amqp service and processes messages using data from the cache, eventually
writing the results to a database.

The naive approach is to write a simple initialisation:

1. Make http request
2. Process response
3. Update cache
4. Subscribe to AMQP
5. Process incoming messages
6. Read from cache
7. Write to database

In order to test this code we could replace some parts with mocks. One way we
could do this is to identify the noun's in our system. Let's call them services
and see where we get to:

1. Make http request            (http service)
2. Process response             (http processing service)
3. Update cache                 (cache service)
4. Subscribe and consumer AMQP  (consumer service)
5. Process incoming messages    (amqp processing service)
6. Read from cache              (cache service)
7. Write to database            (database service)

To be continued...
