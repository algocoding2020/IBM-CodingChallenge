# IBM-CodingChallenge

#Application UI:

![image](https://user-images.githubusercontent.com/69389020/177593018-205b7b6a-e1d5-425a-b72f-a4af9ed732a6.png)

 
We are going to present the user with a little form at the top that is going to ask them what index
they want us to calculate. So, for example, a user might enter in right here seven and then they would click on Submit. When the user clicks on Submit, we are going to take that index and then we are going to have some backend processes or some servers that is going to calculate the Fibonacci value at Index seven. And so eventually our application for Index seven, we need to calculate the value 21. After the user submits that number right there, we would add the number seven onto this list of indices that our application has seen. So, I would expect to see seven added on there.
And then we should eventually also calculate the appropriate value for index seven. And so eventually I should see some line entry here for index seven I calculated 21 like so.
So that is the application, essentially a fancy Fibonacci calculator.

#Diagram of the development flow or the development architecture application
![image](https://user-images.githubusercontent.com/69389020/177593154-35c17313-90f0-43e0-9e9a-221b3f357ab5.png)


 
Here is the back end. Now this right here is a diagram of the development flow or the development architecture of our application. So, when a user boots up their browser and tries to visit our application, they are going to first visit a Nginx web server. The Nginx server is going to essentially do some routing. This server is going to decide whether the browser is trying to access a React application to get some front-end assets like the HTML file or some JavaScript file that will be used to build this application. If the browser is trying to access some front-end assets like an HTML file or a JavaScript file, it will automatically route the incoming request to a running React server. If the incoming request is instead trying to access some back-end API that we are going to use for submitting numbers and reading numbers and retrieving values, all that kind of good stuff. Then the Nginx server right here will instead route the request to an express server. So, this express server here is going to function as our API that is going to serve up information or
calculated values up to the front-end application.


Now, let me show you a couple of more diagrams that is going to better explain this process right here.
![image](https://user-images.githubusercontent.com/69389020/177593196-4e587b1b-e539-430c-8a8b-39cb8ad0ab9f.png)
 
So, you might have noticed that on the last diagram we had these workers Redis and postgress things over here. Redis is an in-memory data store, and it is very commonly used for housing temporary or kind of cached values of sorts. I have also got postgress right here, which is a database. So, you might have noticed that in our web application mock-up we had kind of these two sets of values right here. We had first values that the application has seen or essentially values that have been submitted to the application. All the information for these values I have seen is going to be stored in a PostgreSQL database. And so, you can kind of imagine that values I have seen right here or really indices I have seen, is a very permanent stored set of data all coming from PostgreSQL. On the other hand, the calculated values that are going to be displayed right here, all this information
is going to be displayed in a separate Redis database instead.

Now let me show you a flow of how our application is really going to behave behind the scenes.
![image](https://user-images.githubusercontent.com/69389020/177593295-44ad9c7b-5004-4236-bd8a-966bcee2fa5c.png)

 
So, let's imagine that a user submits a number to the React application. Like let’s say they put a number into the form right here and then click the submit button. So when a user clicks on that submit button, the React app is going to make a API request or assuming an AJAX request to the back end express server, the express server, when it receives this number that it needs to calculate a Fibonacci number for, it's going to first take that number and store it inside of our PostgreSQL database because remember, that's going to have a permanent list of all the indices that have ever been submitted to our application. At the same time, the express server is also going to take that index and put it into the Redis database as well. When a new number shows up inside of our Reddit database, it is going to wake up a separate backend Node.js process that we are going to refer to as the worker. The only job of this worker right here is to watch Redis for new indices that show up. Any time a new index shows up inside of Redis. The worker is going to pull that value out. It will calculate the appropriate Fibonacci value for it. It will take that calculated value and then put it back into Redis so that it can then be requested by the React application and eventually show up on the screen.


#Deployment strategy:
![image](https://user-images.githubusercontent.com/69389020/177593346-5f8336d9-10aa-4fd4-8999-0ee14e7cab69.png)
 

#Kubernetes Deployment:
![image](https://user-images.githubusercontent.com/69389020/177593399-455e51c3-c04d-430f-8c1a-218f0fe3e083.png) 

#Travis config file:
![image](https://user-images.githubusercontent.com/69389020/177593431-5f41cab8-a2af-45f8-8d66-1643ef6f3283.png)

 
