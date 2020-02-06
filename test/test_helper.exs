# In order to use Mox.Server we need to ensure all applications for
# dependencies are loaded, and to call `Appplication.spec/2` requires that
# the application has been loaded
import Application

load(:example)
Enum.each(spec(:example, :applications), &ensure_all_started/1)

# Define our mocks
Mox.defmock(Example.MockService, for: Example.ServiceBehaviour)

# Start the test framework
ExUnit.start()
