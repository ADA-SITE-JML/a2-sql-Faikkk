[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/JCpTxXs5)

Task 1:
Let's say that a company wants to keep record of the laptops given to the employees.
Considering that there will not be a huge variety of laptops, it makes sense to store
the list of laptops in a separate table and refer to it from another table, containing data
about the employee.

Instead of SERIAL, we will declare the ID column as an identity column, which is a more
robust approach, as it will prevent the accidental insertion of the values.

Task 2:
Then, let's say that we want to add a new column to the Laptop table that
will show the model year.

I have declared varchar, but ideally it should be integer.
Leaving the column as a varchar might cause the problem in the long run, when there
might be a need to perform arithmethic operations on the column.
  
Task 3:
CHECK - a constraint which ensures that the values in a column satisfy a specific
condition before being inserted or updated.

UNIQUE - ensures that a column contains only unique values

NOT NULL - no null values

Task 4:
We will create two tables: 
Let's say that we want to store information about the EVs. Considering that one specific model
can be offered with various electric motors, it makes sense to create another table that will store these
engine options, and reference them using the foreign keys in EVs table.

Task 5:
Regular vs materialized view
Regular is used for dynamic retrieval of the data, so that every time, upon execution,
the up-to-date information is retrieved from the table.

Materialized view stores the result of the query. This type of view is used when workign with complex queries.
Unliek the regular view, it should be updated manually, which makes sense, as it is expensive to keep complex queries up-to-date dynamically.
The refreshes are either done manually or automatically, in a scheduled way.

Task 6:
Dividing a big table into 2 smaller ones.

Task 7:
Demonstration of how COMMIT and ROLLBACK work.
