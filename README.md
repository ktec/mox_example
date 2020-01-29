# Example

This project demonstrates a problem using Mox with a supervised singleton style
GenServer.

The problem can be briefly summarised as follows:

When a `GenServer` is added to the static application supervision tree, it will
be started by default. If this `GenServer` depends on a service which you would
like to replace with a mock in tests, this is only possible if your service is
not invoked during the `GenServer` start up process, so `start_link`, `init`,
`handle_continue` etc. If you attempt to call your service during any of these
functions, whilst the code may work in production, in tests when a mock is
defined with `Mox.defmock` call, it is already too late to define an expection.

Here in this project we have:

- [Example.Worker](lib/example.worker.ex)
- [Supervision Tree](lib/example/application.ex)
- [Example.DefaultService](lib/example/default_service.ex)
- [WorkerTest](test/worker_test.ex)

The mock is defined inside the test, but you could of course define the test in
the `test_helper.ex` as suggested by the [Mox README](https://github.com/dashbitco/mox/blob/master/README.md) but this makes no difference to the result.

There are "work arounds" of course, but none are particularly wholesome.

1. You could define your own TestMock module, which means it will be defined at
the time of application boot.
2. You could test for the `Mix.env` or `function_exported?` but uggg!!
3. You could call `mix test --no-start` and manually start.

## Question

- What is your suggested approach to deal with this?
- Are we testing the wrong abstraction?
- Should we go with a [hand crafted mock](test/support/service_mock.ex)?
- Are there any other options to solve this?
