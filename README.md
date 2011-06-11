This is an app that exactly replicates the functionality of [Apple's CoreDataBooks sample code](), but does so using [the excellent PlausibleDatabase library]() from [Plausible Labs]().

PlausibleDatabase gives us a thin Objective-C layer over SQLite, so we end up with the best of both worlds -- clean, easy-to-read Objective-C code that directly uses SQLite for storage.

Take a look at Books.sqlite in the root. We use the same data model for a Book object as in Apple's CoreDataBooks project, which means we use this schema for our SQLite table:

> CREATE TABLE books (id integer primary key asc, title text not null, author text not null, copyright timestamp not null);

You can verify this yourself by investigating the sqlite file from the command line.

$ sqlite3 Books.sqlite
> .schema

To "initalize" the database, we check and see if an editable copy exists in the Documents directory. (This is a standard place to store the editable version of your SQLite file.) If one doesn't exist, we use the empty SQLite file in the bundle as a starting point.

So, if your application needed to ship with a core, default set of data, you would set it up in your original SQLite file using INSERT and UPDATE statements. This would ensure that the app starts with your pre-populated database. In our case, we don't want to start with any data, so we skip this step.

From there, the viewController level functionality parallels the functionality available in CoreDataBooks, but the underlying database access layer is subtly different. You can start by reading the code for the ViewControllers, which should be very familiar if you've already read CoreDataBooks, and then go from there to read the database access layer and contrast it with the CoreData access layer that Apple wrote.

This is a very simple project that omits a lot of the fancy functionality that is possible with SQLite, including custom search engines and high-performance caching. Those are left as exercises for the reader. :)