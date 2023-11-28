# Platos Pizza Sales Analysis

## Introduction 
This is challenge arranged by Maven Analytics. To see all the detail please click [here](https://mavenanalytics.io/challenges/maven-pizza-challenge/4)



**Table of Contents**:
   - [Challenge Objective](#Challenge-Objective)
   - [Data Sources](#data-sources)
   - [Tools Used](#tools-used)
   - [Skills Demonstrated](#skills-demonstrated)
- [Conclusion and Recommendations](#conclusion-and-recommendations)


### Challenge Objective:

For the Maven Pizza Challenge, you’ll be playing the role of a BI Consultant hired by Plato's Pizza, a Greek-inspired pizza place in New Jersey. You've been hired to help the restaurant use data to improve operations, and just received the following note:
<br>

Welcome aboard, we're glad you're here to help!

Things are going OK here at Plato's, but there's room for improvement. We've been collecting transactional data for the past year, but really haven't been able to put it to good use. Hoping you can analyze the data and put together a report to help us find opportunities to drive more sales and work more efficiently.

Here are some questions that we'd like to be able to answer:

- What days and times do we tend to be busiest? 
- How many pizzas are we making during peak periods? 
- What are our best and worst selling pizzas? 
- What's our average order value? 
- How well are we utilizing our seating capacity? (we have 15 tables and 60 seats)


### Data Sources:
- The dataset was obtained from Maven Analytics and is publicly accessible.
- Minimal preprocessing was performed, focusing on date and time column adjustments for compatibility. The data was already clean and ready for analysis.
- All dataset files are included within the project repository.

It contains 4 sheets/tables:
1. ORDERS
2. ORDER_DETAILS
3. PIZZAS
4. PIZZA_TYPES

### Assumptions:
1. The size of party is calculated by the quantity and size of pizza Ordered, where each pizzas serving capacity is given following:<br>
number of people ( Rounding Down  ) <br>
S: 1 , M: 1.5, L: 2, XL: 2.5, XXL: 3
2. Each party dines for 1 hour
3. The restaurant currently have 15 tables, seating 4 people each. Group do not share table i.e 5 people will take 2 tables.

### Tools Used:
**SQL** for data analysis and **Power BI** for data trasformation and data visualization. 

### Skills Demonstrated:
1. Data Manipulation
2. Data Visualization
3. Data Cleaning
4. Statistical Analysis
5. Problem Solving

### Conclusion and Recommendations:
Recommendations to improve sales and work efficiency:

1. Focus on promoting pizzas that excel in both revenue and unit solds.
2. Cut the Brie Carre and Calabrese pizza. They are among the least solds.
3. The Classic category has the highest revenue. It should be your primary focus.
4. Introduce **'Happy Hour'** between 2 PM and 5 PM to increase customers.
5. Make sure you have enough staff available on weekday between 12 PM and 2 PM and on weekends between 5 PM and 9 PM.
6. Create dedicated seating arrangement for solo diners and couples to ensure the enough seating capacity.Together these group make almost half of all dining parties.

 


