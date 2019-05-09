# encoding: utf-8

module Micropayment
  class Debit

    URL = Config::BASE_URL + "debit/v2.3/nvp/"

    class << self

      def execute(method, data = {})
        API.call(URL, method, data)
      end

      def assert_valid_keys(*opts)
        Micropayment.assert_valid_keys *opts
      end

      def assert_keys_exists(*opts)
        Micropayment.assert_keys_exists *opts
      end


      # "löscht alle Kunden und Transaktionen in der Testumgebung"
      # "deletes all customers and transactions in the test environment"
      def reset_test(options = {})
        options[:test_mode] = 1
        execute(:resetTest, options)
      end

      # "legt neuen Kunden an"
      # "creates new customers"
      def customerCreate(options = {})
        assert_valid_keys(options, :customerId, :freeParams)
        assert_keys_exists(options, :customerId)
        execute(:customerCreate, options)
      end

      # "ordnet weitere freie Parameter dem Kunden zu, oder ändert sie"
      # "assigns or changes other free parameters to the customer"
      def customerSet(options = {})
        assert_valid_keys(options, :customerId, :freeParams)
        assert_keys_exists(options, :customerId)
        execute(:customerSet, options)
      end

      # "ermittelt alle freien Parameter des Kunden"
      # "determines all free parameters of the customer"
      def customerGet(options = {})
        assert_valid_keys(options, :customerId)
        assert_keys_exists(options, :customerId)
        execute(:customerGet, options)
      end

      # "ermittelt alle Kunden"
      # "detects all customers"
      def customerList(options = {})
        assert_valid_keys(options, :from, :count)
        execute(:customerList, options)
      end

      # "erzeugt oder ändert Bankverbindung eines Kunden"
      def bankaccountSet(options = {})
        assert_valid_keys(options, :customerId, :iban, :bic, :country, :bankCode, :accountNumber, :accountHolder, :holderAddress,
                          :holderZip, :holderCity, :holderCountry)
        assert_keys_exists(options, :customerId, :accountHolder)
        execute(:bankaccountSet, options)
      end

      # "ermittelt die Bankverbindung des Kunden"
      # "creates or changes a customer's bank account"
      def bankaccountGet(options = {})
        assert_valid_keys(options, :customerId)
        assert_keys_exists(options, :customerId)
        execute(:bankaccountGet, options)
      end

      # "prüft Bankleitzahl und ermittelt Banknamen"
      # "determines the bank account of the customer"
      def bankCheck(options = {})
        assert_valid_keys(options, :iban, :bic, :country, :bankCode)
        execute(:bankCheck, options)
      end

      # "prüft Bankverbindung und ermittelt Banknamen"
      # "checks bank code and determines banknames"
      def bankaccountCheck(options = {})
        assert_valid_keys(options, :iban, :bic, :country, :bankCode, :accountNumber)
        execute(:bankaccountCheck, options)
      end

      # "Sperrt Bankverbindung oder gibt sie frei"
      # "Lock or unblock your bank account"
      def bankaccountBar(options = {})
        assert_valid_keys(options, :iban, :bic, :country, :bankCode, :accountNumber, :barStatus)
        assert_keys_exists(options, :barStatus)
        execute(:bankaccountBar, options)
      end

      # "erzeugt oder ändert Adressdaten eines Kunden"

      def addressSet(options = {})
        assert_valid_keys(options, :customerId, :firstName, :surName, :company, :street, :zip, :city, :country)
        assert_keys_exists(options, :customerId)
        execute(:addressSet, options)
      end

      # "ermittelt die Adresse des Kunden"
      # "determines the address of the customer"
      def addressGet(options = {})
        assert_valid_keys(options, :customerId)
        assert_keys_exists(options, :customerId)
        execute(:addressGet, options)
      end

      # "erzeugt oder ändert Kontaktdaten eines Kunden"
      # "creates or changes a customer's contact information"
      def contactDataSet(options = {})
        assert_valid_keys(options, :customerId, :email, :phone, :mobile)
        assert_keys_exists(options, :customerId)
        execute(:contactDataSet, options)
      end

      # "ermittelt die Kontaktdaten des Kunden"
      # "determines the contact information of the customer"
      def contactDataGet(options = {})
        assert_valid_keys(options, :customerId)
        assert_keys_exists(options, :customerId)
        execute(:contactDataGet, options)
      end

      # "erzeugt einen neuen Bezahlvorgang"
      # => "löst die Benachrichtigung sessionStatus mit dem Status "INIT" bzw. "REINIT" aus"
      # "creates a new payment process"
      # => "triggers the notification sessionStatus with the status" INIT "or" REINIT "
      def sessionCreate(options = {})
        assert_valid_keys(options, :customerId, :sessionId, :project, :projectCampaign, :account, :webmasterCampaign,
                          :amount, :currency, :title, :payText, :ip, :freeParams, :mandateRef, :mandateSignDate, :mandateRecur)
        #mandateRecur => [ONEOFF, RECURRING, FINAL]
        assert_keys_exists(options, :customerId, :project)
        execute(:sessionCreate, options)
      end

      # "ordnet weitere freie Parameter der Session zu, oder ändert sie"
      # "assigns or changes other free parameters of the session"
      def sessionSet(options = {})
        assert_valid_keys(options, :sessionId, :freeParams)
        assert_keys_exists(options, :sessionId)
        execute(:sessionSet, options)
      end

      # "ermittelt Daten eines Bezahlvorgangs"
      # "determines data of a payment transaction"
      def sessionGet(options = {})
        assert_valid_keys(options, :sessionId)
        assert_keys_exists(options, :sessionId)
        execute(:sessionGet, options)
      end

      # "bestätigt den Lastschrifteinzug eines Vorgangs"
      # => "löst die Benachrichtigung sessionStatus mit dem Status "APPROVED" aus"
      # "confirms the direct debit of a transaction"
      # => "triggers the notification sessionStatus with the status" APPROVED ""
      def sessionApprove(options = {})
        assert_valid_keys(options, :sessionId)
        assert_keys_exists(options, :sessionId)
        execute(:sessionApprove, options)
      end

      def sessionCredit(options = {})
        assert_valid_keys(options, :customerId, :sessionId, :amount, :payText)
        #mandateRecur => [ONEOFF, RECURRING, FINAL]
        assert_keys_exists(options, :sessionId, :amount)
        execute(:sessionCredit, options)
      end


      # "übermittelt alle Bezahlvorgänge eines Kunden"
      # "transmits all payment transactions of a customer"
      def sessionList(options = {})
        assert_valid_keys(options, :customerId, :dtmFrom, :dtmTo, :from, :count)
        assert_keys_exists(options, :customerId)
        execute(:sessionList, options)
      end

      # "simuliert die Abbuchung für alle bestätigten Vorgänge"
      # => "erzeugt für jede bestätigte Session eine neue Transaktion mit dem Typ 'BOOKING' und
      # löst die Benachrichtigung transactionCreate aus"
      # => "löst die Benachrichtigung sessionStatus mit dem Status 'CHARGED' aus"

      # "simulates the debit for all confirmed transactions"
      # => "creates for each confirmed session a new transaction with the type 'BOOKING' and
      # triggers the transactionCreate notification "
      # => "triggers the notification sessionStatus with the status 'CHARGED'"

      def sessionChargeTest(options = {})
        execute(:sessionChargeTest, :testMode => 1)
      end

      # "simuliert Stornierung eines einzelnen Vorgangs"
      # => "erzeugt eine neue Transaktion mit dem Typ "REVERSAL" und löst die Benachrichtigung transactionCreate aus"
      # => "löst die Benachrichtigung sessionStatus mit dem Status "REVERSED" aus"

      # "simulates cancellation of a single operation"
      # => "creates a new transaction with the type" REVERSAL "and triggers the transactionCreate notification"
      # => "triggers the notification sessionStatus with the status" REVERSED ""
      def sessionReverseTest(options = {})
        assert_valid_keys(options, :sessionId, :reverseCode, :reverseReason)
        assert_keys_exists(options, :sessionId)
        execute(:sessionReverseTest, options.merge(:testMode => 1))
      end

      # "simuliert die komplette Nachzahlung eines stornierten Vorgangs"
      # => "erzeugt eine neue Transaktion mit dem Typ "BACKPAY" und löst die Benachrichtigung transactionCreate aus"
      # => "löst die Benachrichtigung sessionStatus mit dem Status "RECHARGED" aus, wenn der gesamte
      # offene Betrag beglichen wurde"

      # "simulates the complete additional payment of a canceled transaction"
      # => "creates a new transaction with the type" BACKPAY "and triggers the transactionCreate notification"
      # => "triggers the notification sessionStatus with the status" RECHARGED "if the whole
      # open amount was settled "
      def sessionRechargeTest(options = {})
        assert_valid_keys(options, :sessionId, :amount)
        assert_keys_exists(options, :sessionId)
        execute(:sessionRechargeTest, options.merge(:testMode => 1))
      end

      # "Veranlasst eine (Teil-)Gutschrift und überweist sie zurück"
      # => "erzeugt eine neue Transaktion mit dem Typ "REFUND" und löst die Benachrichtigung transactionCreate aus"
      # "Make a (partial) credit and transfer it back"
      # => "creates a new transaction with the type" REFUND "and triggers the transactionCreate notification"
      def sessionRefund(options = {})
        assert_valid_keys(options, :sessionId, :bankCode, :accountNumber, :accountHolder, :amount, :payText, :iban, :bic, :country)
        assert_keys_exists(options, :sessionId)
        execute(:sessionRefund, options)
      end

      # "simuliert Stornierung der letzten Gutschrift,"
      # => "erzeugt eine neue Transaktion mit dem Typ "REFUNDREVERSAL" und löst die Benachrichtigung transactionCreate aus"
      # "simulates cancellation of the last credit,"
      # => "creates a new transaction with the type" REFUNDREVERSAL "and triggers the transactionCreate notification"
      def sessionRefundReverseTest(options = {})
        assert_valid_keys(options, :sessionId)
        assert_keys_exists(options, :sessionId)
        execute(:sessionRefundReverseTest, options.merge(:testMode => 1))
      end

      # "erstellt eine Transaktion vom Typ "EXTERNAL""
      # => "löst die Benachrichtigung transactionCreate aus"
      # "creates a transaction of type" EXTERNAL ""
      # => "triggers the transactionCreate notification"
      def transactionCreate(options = {})
        assert_valid_keys(options, :sessionId, :date, :amount, :description)
        assert_keys_exists(options, :sessionId, :amount)
        execute(:transactionCreate, options)
      end

      # "ermittelt alle Transaktionen für einen Bezahlvorgang"
      # "determines all transactions for a payment transaction"
      def transactionList(options = {})
        assert_valid_keys(options, :sessionId)
        assert_keys_exists(options, :sessionId)
        execute(:transactionList, options)
      end

      # "ermittelt Daten einer Transaktion"
      # "determines data of a transaction"
      def transactionGet(options = {})
        assert_valid_keys(options, :transactionId)
        assert_keys_exists(options, :transactionId)
        execute(:transactionGet, options)
      end

      # holders for callbacks
      #
      # Notifies on every change of the session status, and adds other free parameters
      #  initiated by the functions sessionCreate and sessionApprove
      #  also sessionChargeTest, sessionReverseTest and sessionRechargeTest respectively the corresponding events
      def sessionStatus(options = {})
        assert_valid_keys(options, :sessionId, :status, :freeParams)
        assert_keys_exists(options, :sessionId, :status, :freeParams)
        #status => ["INIT", "REINIT", "APPROVED", "CHARGED", "REVERSED", "RECHARGED"]
        options

      end

      # Notified on creation of a new transaction
      #  is initiated by the functions sessionChargeTest, sessionReverseTest, sessionRechargeTest, transactionCreate,
      # sessionRefund, sessionRefundReverseTest respectively the corresponding events
      def sessionStatus(options = {})
        assert_valid_keys(options, :sessionId, :transactionId, :date, :type, :amount, :description)
        assert_keys_exists(options, :sessionId, :transactionId, :date, :type, :amount, :description)
        #type => [ "BOOKING", "REVERSAL", "BACKPAY", "EXTERNAL", "REFUND", "REFUNDREVERSAL"]
        # #amount if eur cent
        options

      end

    end

  end
end
