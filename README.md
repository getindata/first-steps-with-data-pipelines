# First steps with Data Pipelines

## Description

This is an example of a simple [Data Pipelines](https://data-pipelines-cli.readthedocs.io/en/latest/index.html) project template with a small amount of data and a simple pipeline and test scenario.
You can learn the basics of how to work with the tool. Below we will describe the steps of how to use [Data Pipelines](https://data-pipelines-cli.readthedocs.io/en/latest/index.html) tool for creating new projects using an existing project template and how to
use the tool for running simple data pipelines on [GCP BigQuery](https://cloud.google.com/bigquery).
This project can be used as a project template for [Data Pipelines](https://data-pipelines-cli.readthedocs.io/en/latest/index.html) tool.
Hopefully thanks to this you will make your first steps with [Data Pipelines](https://data-pipelines-cli.readthedocs.io/en/latest/index.html) tool faster.

This is an example of a simple [Data Pipelines](https://data-pipelines-cli.readthedocs.io/en/latest/index.html) (DP) project. If you are looking for a more advanced project, a project with many pipelines, tables and
views, tests and seeds you can find it [here](https://github.com/getindata/tpc-h-data-pipelines-demo.git).

## Prerequisites
- A project will be run on local machine
   and the results of our pipelines will be stored on [GCP BigQuery](https://cloud.google.com/bigquery) connected with your project
- Access to GCP account and projects via CLI 
- Some experience with a command line
- Basic understanding of SQL

## Data used
For the purpose of this simple project demo we will use the data from 2 CSV files that are placed in the seeds folder.
No other data is being used. Data in both of the CSV files was generated.

## First steps with Data Pipelines

### 1. Environment preparation

Here we will explain how to make it possible to run [Data Pipelines](https://data-pipelines-cli.readthedocs.io/en/latest/index.html). Let's first clone this repo to your machine and then  need to install Data Pipelines CLI:
```
pip install data-pipelines-cli[<flags>]
```
Depending on the systems that you want to integrate with you need to provide different flags in square brackets. For purpose of our project we will use:
```
pip install data-pipelines-cli[gcs,git,bigquery]
```

If you want to get more information about installation of Data Pipelines CLI follow the documentation - [Data Pipelines Documentation](https://data-pipelines-cli.readthedocs.io/en/latest/installation.html)

### 2. Initialization of Data Pipelines tool

We expect that the whole organization will be using the same [Data Pipelines](https://data-pipelines-cli.readthedocs.io/en/latest/index.html) initialization project that specifies which
templates (DP projects) they are using. Initialization makes it possible to set up some dp variables that can be used
across the whole company. We specify the repository path where we specified the variables that we want dp to be using.
We can have many initialization repos depending on what we want to do with our project.

Here is how you can initialize dp:
```
dp init <path to init repo>
```

If this if your first DP project and you do not have your own templates of projects then
here is an example of a publically available DP init repository that you can use:
```
dp init https://github.com/getindata/data-pipelines-cli-init-example
```

For the purpose of this demo the only variable we will be asked for is going to be
```username``` which is used in many dp commands. We can specify our username as shown below:

![](images/project_init_username_specification.png)

You can add more options to dp.yml file with other templates of projects to choose from. Specify their template_names
and the template_paths to git repositories. You can also specify more vars for use in your projects.
The example initialization asks about the name of user, this name will be later used in other operations but
you typically have to run init command only once.

### 3. Creating our own project

After the initialization is complete we can start using DP. Now we will ```create``` a project using a project template.
The ```dp create``` command can look like this:

```
dp create <project path> <template path> 
```

```project path``` says in which folder our project, that will be created should be placed. Usually this is just a directory name.
```template path``` is a path of a template to use for creating a new project. This parameter can be skipped - then
we are able to choose one template of a project from a list specified in the ```.dp.yml``` file.

For the purpose of this demo, we will use a template already specified in `.dp.yml` file. After executing this command:
```
dp create our-simple-project
```
we should be able to choose a template that we want to use from a list. 

![](images/project_creation_template_specification.png)

We can switch options by pressing up and down buttons and we can make a decision by pressing enter. For this demo we are going
to use ```first-steps-with-data-pipelines``` template, which is actually the project that you are reading right now.

After pressing enter button, we will be asked some questions about which template to use for a new project, the name of the project,
the name of GCP project that we are working on, the cron that specifies at what times should the DP pipeline run and a
description of the created project. Answer these questions. Be aware that the name of the DP project should be composed of alpha-numeric signs and the `_` sign.

![](images/project_creation_options_filled_in.png)

After answering these questions [Copier](https://copier.readthedocs.io/en/stable/) will be used to create contents of our projects using the specified project template.
Good job! The project should have been created successfully.

Now let's enter the project folder.

```
cd our-simple-project
```

### 4. Config files in config directory

In the ```config``` directory you can find some environment configuration files. These files will be modified were generated from a project template that we used.
When you want to use [Data Pipelines](https://data-pipelines-cli.readthedocs.io/en/latest/index.html) in the future, you will be able to specify the configuration that is suitable for your project.

![](images/configuration_files.png)

For the purpose of this demo you do not have to worry about making changes in these files. We can use the default configuration.

### 5. Running pipelines and tests using Data Pipelines tool

This project consists of:
- 2 ```seeds```
- 1 ```model```
- 1 ```test```

To understand more about ```models```, ```tests``` and ```seeds``` please read about them at the
[DBT Documentation](https://docs.getdbt.com/docs/building-a-dbt-project/documentation).

#### 5.1 Executing seeds

When we have our environment ready and the project has been created, the first thing we should do is to execute the ```seeds```.
In this repository there are 2 CSV files specified that contain some data. DBT will use these 2 files as ```seeds```.
After running this command the tables with contents of CSV files will be created in a BigQuery dataset.
The name of the dataset we use is created using our ```username``` value that we provided in the initialization step.
Make sure that you are in the project folder and execute the ```seeds``` with this command:

```
dp seed
```

If we execute the ```seeds``` more times than one then the contents of the tables will be replaced with the same values.
Unless we change the contents of CSV files there will be no change. This is why usually we will only have to run the command once, in the beginning of our work.

Here is an example of what output of this command can look like based on the contents of this repository.

![](images/simple_output_seed.png)

When the process is finished let's check the contents of our BigQuery dataset.
Below is a picture that presents the contents of 2 tables generated in BigQuery based on the 2 ```seed``` CSV files:

![](images/simple_bigquery_seed.png)


#### 5.2 Executing models

The contents of the tables that were created in the ```Executing seeds``` step can be later used in some of the models that we specify.
Now we should be ready to run our models. In the models folder of our template we have specified 1 model that uses the 2 ```seed``` tables.

Execute the command.

```
dp run
```

![](images/simple_run_output.png)

This process will look at the contents of the models directory and create coresponding tables or views in our BigQuery Dataset:

![](images/simple_run_bigquery.png)

#### 5.3 Executing tests

Now after all the tables and views are created we can also check, if the models work as intended by running the tests.
We can have tests that check if the logic behind a query works as intended for a set of data. Let's run the tests.

```
dp test
```

![](images/simple_test_output.png)

We should be able to see the summary, we can see if everything with our models is fine and there are no errors.

### Next steps
If you are interested in more advanced use of [Data Pipelines](https://data-pipelines-cli.readthedocs.io/en/latest/index.html) you can check
[this repository](https://github.com/getindata/tpc-h-data-pipelines-demo.git). By familiarizing yourself with this resource, you will get 
 a better understanding on how [Data Pipelines](https://data-pipelines-cli.readthedocs.io/en/latest/index.html) could look like in your production project. Remember to push your work to your [Git](https://git-scm.com/doc) repository before stopping it if you want to continue in the future.

## Resources

- More about [data-pipelines-cli](https://data-pipelines-cli.readthedocs.io/en/latest/usage.html#)
- More about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers about `dbt`
- Rendering project templates with [Copier](https://copier.readthedocs.io/en/stable/) 
- Data pipelines orchestration with [Airlfow](https://airflow.apache.org/) 