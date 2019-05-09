# micropayment

Implemantation of the NVP API provided by micropayment.de.
If you want to use it in your Rails project please use [micropayment-rails](https://github.com/GeneralScripting/micropayment-rails)


WIP!

## Installation

    gem install micropayment

## Usage

First you need to setup at least your API key:

    Micropayment::Config.api_key = 'xxx'
    # to enter sandbox mode:
    Micropayment::Config.sandbox = 1

Let's try out a test payment using direct debit:

```
# create a customer
customer =  Micropayment::Debit.customerCreate(
   :customerId => Time.now.to_i.to_s, 
   :freeParams => {
     "first_name" => "John", 
     "last_name" => "Doe"
     }
)

customer_data = Micropayment::Debit.customerGet(:customerId => customer["customerId"])


# add a bank account to the customer
Micropayment::Debit.bankaccountSet(
  :customerId     => customer["customerId"],
  :iban => 'DE89888888881234567890', 
  :bankCode => '88888888',
  :bic => 'TESTDE00XXX',
  :accountNumber => '1234567890',
  :country => 'DE',
  :accountHolder  => "#{customer_data['freeParams[first_name]']} #{customer_data['freeParams[last_name]']}"
)

# create a session
your_project_id ='1ohg-l6mtc-49a5cc9c' 
session = Micropayment::Debit.sessionCreate(
  :customerId => customer["customerId"],
  :project    => your_project_id,
  :amount     => 10.00,
  :payText    => 'Thank you for ...',
  :payRecurState => "ON",
  
)

Micropayment::Debit.sessionApprove(
  :sessionId  => session["sessionId"]
)
Micropayment::Debit.sessionChargeTest(
  :sessionId  => session["sessionId"]
)

Micropayment::Debit.sessionReverseTest(
  :sessionId  => session["sessionId"],
  :reverseCode => 0,
  :reverseReason => 'UNKNOWN' #"UNSPECIFIED", "ACCOUNT_EXPIRED", "ACCOUNT_WRONG", "NOT_AUTHORIZED", "CONTRADICTED", "UNKNOWN"
 
)
```

```
Micropayment::Debit.customerList
#=> { "error"=>"0", "count"=>"2", "maxCount"=>"2", "customerIdList"=>["id1", "id2"] }
```


## Contributing to micropayment
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2012 General Scripting UG (haftungsbeschränkt). See LICENSE.txt for further details.

