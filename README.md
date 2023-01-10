# ServiceLocatorMh

service_locator_mh is a super simple implementation of service locator pattern for Ruby on Rails, inspired on [dajulia3/listings_controller](https://gist.github.com/dajulia3/5479980).

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add service_locator_mh

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install service_locator_mh

## Usage
### Register a service
Modify your "config/application.rb" to register your services as below:
```
config.before_configuration do
    ServiceLocator.instance.register_by_type(StockPricesService, StockPricesService.new)
    ServiceLocator.instance.register_by_type(IntradayStockPricesService, IntradayStockPricesService.new)
    ServiceLocator.instance.register_by_name('MyService', MyService.new)
end
```
You could register different service instances depending on the environment or any custom logic:
```
config.before_configuration do     
    if ENV['FAKE_SERVICES'] == 'true' || Rails.env == 'test'
      puts 'Using fake services'
      ServiceLocator.instance.register_by_type(StockPricesService, StockPricesServiceFake.new)
      ServiceLocator.instance.register_by_type(IntradayStockPricesService, IntradayStockPricesServiceFake.new)
    else
      ServiceLocator.instance.register_by_type(StockPricesService, StockPricesService.new)
      ServiceLocator.instance.register_by_type(IntradayStockPricesService, IntradayStockPricesService.new)
    end
end
```

### Obtain a service
On your controller, helper or other:
    intradayService = ServiceLocator.instance.get_service_by_type(IntradayStockPricesService)
    intradayService.get_intra_day_prices("GOOG");

    myService = ServiceLocator.instance.get_service_by_name('MyService')
    myService.do_something();

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/herreramaxi/service_locator_mh.
