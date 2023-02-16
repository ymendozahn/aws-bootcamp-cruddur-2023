# Week 0 — Billing and Architecture

So, before I begin I like to thanks Andrew Brown and the team for this great opportunity to learn AWS stuff.

I just finish the additional video for setting up Credentials, using AWS CLI, and the Billing and budget settings.

Before I start creating credentials, I read some tips posted on https://www.linuxtek.ca/2023/02/12/aws-cloud-project-bootcamp-week-0-unofficial-homework-guide/. It was of help for me because I already had an account for about 9 month now, which I used for study and pass the Cloud Practitioner Exam. I Created an organization and added a new account with my gmail+thing email address. I also already had a Domain registered with Route 53 that I'm going to use for this bootcamp.

## Back to my learning

So far what I have done is:
1. I went and create a user with admin and billing permissions, secure it with [MFA Authy app](https://authy.com/). Its a great soft MFA service where you can have many accounts from different sites
2. For the billing part. I created using the GUI, but I also try the AWS CLI, with the json files on gitpod. I had some trouble at first with the syntax. Im not familiar with json files, but I created a budget and then delete it :-) 
3. For the architectural design. I Use Lucidchart as instructured. I think it's easy to use and it's great that there are shape libraries for popular platforms like AWS. In the past I use Microsoft Visio and sometimes it was a little pain to import shapes and icons. So, this is really cool.

## Required Homework

### Admin user and secure account with MFA

I created a IAM user with admin and billing priviledges using the built-in policies: 
+ **AdministratorAccess**, which provides full access to AWS services
+ **Billing**, which grants permissions for billing and cost management

My admin IAM user is call **yuriman**. It's my nickname from college 🙂

![IAM user](images/AdminUser02.PNG)

I also secure it with a virtual MFA call [**Authy**](https://authy.com/). It's simple and user friendly MFA app.

![IAM user with MFA enabled](images/AdminUser03.PNG)

### Install AWS CLI

I didn't have any problems with it, just running fine. Here is the link to my [gitpod.yml](https://github.com/ymendozahn/aws-bootcamp-cruddur-2023/blob/61318ab0f599c0c6181d7959c2ed7f68e0c1a3a3/.gitpod.yml#L1-L10) file 


### Conceptual and Logical Diagram

Here is my **Conceptual Design**. I didn't have a napkin but I use a paper towel during my lunch break. It's a little mess but the idea is there. 

![Conceptual-design](https://user-images.githubusercontent.com/67177646/219129918-224cafa2-805f-4d6e-bc46-4119f3f93d25.jpeg)

Here is the link for lucidchart: [Conceptual Design](https://lucid.app/lucidchart/bfaf1319-01ed-4481-acee-d43a7c027719/edit?viewport_loc=-89%2C182%2C2048%2C962%2C0_0&invitationId=inv_993eed86-c418-4e16-a966-9d5a596c266b)

And here is my **Logical Design**. I know it's the same as the example, but, maybe I can modified later as we advance with the bootcamp.

<img width="542" alt="Logical-Design" src="https://user-images.githubusercontent.com/67177646/219122002-845f8285-c713-4c6c-9de8-ed5fbdce5689.PNG">

Here is the link for lucidchart: [Logical Design](https://lucid.app/lucidchart/ddfaf6f2-74a7-4d74-91a1-332448b12aae/edit?viewport_loc=-130%2C-13%2C2131%2C827%2CcbsxpdK4zMIe&invitationId=inv_9ca2c4c2-859f-49db-a63a-b4be8b03ac79)

### Service Limits

I search for the Free tier service limits on AWS services we are going to use for the project. I'll going to updated it as we advance with the bootcamp

 | AWS Service | Free Tier per month limit | Basic Pricing |
 | ----------- | ------------------------- | ------------- |
 | AppSync     | 250,000 query or data modification operations <br /> 250,000 real-time updates <br /> 600,000 connection-minutes | pricing is base on instance type and other factors. Details here |
 | | | |
 

