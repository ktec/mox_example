# With a hard coded mock like this we can define the behaviour
# before the application starts up, but do we even need Mox at
# this point?
#
# defmodule Example.MockService do
#   @behaviour Example.ServiceBehaviour
#
#   def foo() do
#     "hard coded says foo"
#   end
# end
