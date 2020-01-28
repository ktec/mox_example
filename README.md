# Example Project Demonstrating Problem using Mox

This project highlights an issue when using the Mox library. This problem may
occur with other mocking libraries, but we're using Mox so that's why this
example does too.

The problem can be briefly summarised as follows:

When a `GenServer` is added to the static application supervision tree, it will
be started by default. If this `GenServer` depends on a service which you would
like to replace with a mock in tests, this is only possible if your service is
not invoked during the `GenServer` start up process, so `start_link`, `init`,
`handle_continue` etc. If you attempt to call your service during any of these
functions, whilst the code may work in production, in tests when a mock is
defined with `Mox.defmock` call, it is already too late to define an expection.

There are "work arounds" of course, but none are particularly wholesome.

1. You could define your own TestMock module, which means it will be defined at
the time of application boot.
2. You could test for the `Mix.env` or `function_exported?` but uggg!!
3. You could call `mix test --no-start` and manually start.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `example` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:example, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/example](https://hexdocs.pm/example).
