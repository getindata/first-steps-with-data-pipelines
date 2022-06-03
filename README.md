# First steps with Data Pipelines

This is an example of a simple Data Pipeline project with small amount of data and a simple pipeline and test scenario.
The purpose is to show you how the contents of a project can look like to create a simple data processing pipeline.
Hopefully thanks to this you will make your first steps with Data Pipeline tool faster.

This is an example of a simple Data Pipeline project. If you are looking for a more advanced project, a project with many pipelines, tables and
views, tests and seeds you can find it [here](https://github.com/getindata/tpc-h-data-pipelines-demo.git).

## Environment preparation

Here we will explain how to make it possible to use Data Pipeline on an instance of
GCP Vertex AI JupyterLab notebook.

Go to Vertex AI on GCP console. On the menu choose Workbench. You should be able to see currently existing Notebooks.
For purpose of this example create a new notebook. We will be using our publically available environment image.

Click new Notebook button. There choose "Customize...". Name your notebook, specify Region and Zone
and for environment scrollbar choose "Custom container" option.
Then for docker container image paste the image:
```
gcr.io/getindata-images-public/jupyterlab-dataops:bigquery-1.0.5
```

You can configure the rest of the parameters or leave them as they are.
When you are done click Create button. After some time an instance of Notebook with
proper image installed should be available and we should be able to start setting up
the environment.

## Data used

For the purpose of this simple project demo all we use the data from 2 CSV files that are placed in the seeds folder.
No other data is being used. Data in both of the CSV files was generated.

## Config files in config directory

There are many files describing the configuration of the environment. These files were generated from template.
For the purpose of this demo you do not need to worry about altering the contents of these files.

## Setting up DP

We expect that the whole organization will be using the same Data Pipeline initialization project that specifies which
templates (DP projects) they are using. Initialization makes it possible to set up some dp variables that can be used
across the whole company. We specify the repository path where we specified the variables that we want dp to be using.
We can have many initialization repos depending on what we want to do with our project. For the purpose of this demo
the only variable we are going to use in the init repository is going to be
```username``` which is going to be used in many dp commands.

Here is how you can initialize dp:
```
dp init <path to init repo>
```

If this if your first DP project and you do not have your own templates of projects then
here is an example of a publically available DP init repository that you can use:
```
dp init https://github.com/getindata/data-pipelines-cli-init-example
```

You can add more options to dp.yml file with other templates of projects to choose from. Specify their template_names
and the template_paths to git repositories. You can also specify more vars for use in your projects.
The example initialization asks about the name of user, this name will be later used in other operations but
you typically have to run init command only once.

## Creation of our project

After the initialization is complete we can start using DP to create projects with project templates.

```
dp create <project path> <template path> 
```

Project path is a location where we want our project to be created. Usually this is just a directory name.
Here is an example of a publically available template of a DP project:
```
https://github.com/getindata/data-pipelines-template-example
```

Here, we will be asked some questions about which template to use for a new project, the name of the project,
the name of GCP project that we are working on, the cron that specifies at what times should the DP pipeline run and a
description of the created project.

Be aware that the name of the DP project should be written using alpha-numeric signs plus the underscore sign.

After answering these questions Copier will be used to create contents of our projects using the specified project template.

![](/images/project_creation.png)

## Running pipelines and tests using Data Pipeline tool

This project contains some seeds, models and tests that were added to simulate how pipelines could look like at an organization.
To understand more about models, tests and seeds please read about them at the
[DBT Documentation](https://docs.getdbt.com/docs/building-a-dbt-project/documentation).

Here is an example of what output of this command can look like based on the contents of this repository.

```
dp seed
```

![](/images/simple_output_seed.png)

In this repository there are 2 CSV files specified that contain some data.
After running this command the tables with contents of CSV files will be created in a BigQuery dataset.
The name of the dataset to put results into is a result of schema name generation. The name of user we specify in
initialization step is used in this process.

Below is a picture of the contents of 2 tables generated in BigQuery based on the seed CSV files:
![](/images/simple_bigquery_seed.png)

The contents of these tables can be used in some of the models that we specify.
Now we should be ready to run our models:

```
dp run
```

![](/images/simple_run_output.png)

This process will look at the contents of the models directory and create coresponding tables or views in our BigQuery Dataset:

![](/images/simple_run_bigquery.png)

Now after all the tables and views are created we can also check, if the models work as intended by running the tests:

```
dp test
```

![](/images/simple_test_output.png)

We should be able to see the summary, we can see if everything is fine or there is an error with a specific test.

### Resources:

- More about [data-pipelines-cli](https://data-pipelines-cli.readthedocs.io/en/latest/usage.html#)
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Understand [Copier](https://copier.readthedocs.io/en/stable/)
- Try [Airlfow](https://airflow.apache.org/)
