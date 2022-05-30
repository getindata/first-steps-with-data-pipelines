FROM fishtownanalytics/dbt:1.0.0

ADD analyses /dbt/analyses/
ADD seeds /dbt/seeds/
ADD macros /dbt/macros/
ADD models /dbt/models/
ADD docs /dbt/docs/
ADD tests /dbt/tests/

ADD dbt_project.yml /dbt/dbt_project.yml
ADD packages.yml /dbt/packages.yml

ADD build/profiles/env_execution/profiles.yml /root/.dbt/profiles.yml

WORKDIR /dbt

# dbt >= 1.0.0 apparently fully parses profiles.yml when running
# `dbt deps` so it fails if the env variable is not set. This hack
# ensures it won't fail.
RUN GCP_KEY_PATH="" dbt deps
