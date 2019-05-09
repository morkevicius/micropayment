# micropayment

Implemantation of the NVP API provided by micropayment.de.
If you want to use it in your Rails project please use [micropayment-rails](https://github.com/GeneralScripting/micropayment-rails)


WIP!

## Installation

    gem install micropayment

## Usage

First you need to setup at least your API key
(you can leave both of these parameters settings if this is more convienient for you,
 would have to send it with the calls directly):

    Micropayment::Config.api_key = 'xxx'
    # to enter sandbox mode:
    Micropayment::Config.sandbox = 1

Let's try out a test payment using direct debit:

```
api_key = Micropayment::Config.api_key || '' # so we dont have to store it here :) 

customer =  Micropayment::Debit.reset_test(:testMode => 1, :accessKey => api_key)
customer =  Micropayment::Debit.customerList(:testMode => 1, :accessKey => api_key)

# create a customer
customer =  Micropayment::Debit.customerCreate(
   :accessKey => api_key,
   :testMode => 1, 
   :customerId => Time.now.to_i.to_s, 
   :freeParams => {
     "first_name" => "John", 
     "last_name" => "Doe"
     }
)


customer_data = Micropayment::Debit.customerGet(  
  :accessKey => api_key,
  :testMode => 1,
  :customerId => customer["customerId"]
)


# add a bank account to the customer
Micropayment::Debit.bankaccountSet(
  :accessKey => api_key,
  :testMode => 1, 
  :customerId     => customer["customerId"],
  :iban => 'DE89888888881234567890', 
  :bankCode => '88888888',
  :bic => 'TESTDE00XXX',
  :accountNumber => '1234567890',
  :country => 'DE',
  :accountHolder  => "#{customer_data['freeParams[first_name]']} #{customer_data['freeParams[last_name]']}"
)

# create a session
your_project_id = '1ohg-l6mtc-49a5cc9c' 
session = Micropayment::Debit.sessionCreate(
  :accessKey => api_key,
  :testMode => 1, 
  :customerId => customer["customerId"],
  :project    => your_project_id,
  :amount     => 100,
  :payText    => 'Thank you for ...',
  :mandateRecur => "RECURRING"
  )

transaction_list =  Micropayment::Debit.transactionList(:testMode => 1, :accessKey => api_key, 
:sessionId  => session["sessionId"])

Micropayment::Debit.sessionApprove(:accessKey => api_key, :testMode => 1, :sessionId  => session["sessionId"])

transaction_list =  Micropayment::Debit.transactionList(:testMode => 1, :accessKey => api_key, 
:sessionId  => session["sessionId"])

Micropayment::Debit.sessionChargeTest(:accessKey => api_key, :testMode => 1, :sessionId  => session["sessionId"])

Micropayment::Debit.sessionReverseTest(
  :testMode => 1, 
  :accessKey => api_key, 
  :sessionId  => session["sessionId"],
  :reverseCode => 0,
  :reverseReason => 'UNKNOWN' #"UNSPECIFIED", "ACCOUNT_EXPIRED", "ACCOUNT_WRONG", "NOT_AUTHORIZED", "CONTRADICTED", "UNKNOWN"

)
```

```
Micropayment::Debit.customerList(:accessKey => api_key, :testMode => 1)
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

