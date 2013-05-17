
RailsList
=========

Simple rails application for managing lists of things.


Installation / Setup
--------------------

* Create Postgres users (or edit config/database.yml to use sqlite3)
```
createuser -dRSl railslist_dev
createuser -dRSl railslist_test
createuser -dRSl railslist
```

* Update bundle
```
bundle
```

* Migrate schema
```
rake db:create
rake db:schema:load
```

* Start development server
```
rails s
```


