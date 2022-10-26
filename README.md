Bem-vindo ao projeto demo da Northwind!

### O que é este projeto?

Este projeto é um projeto exemplo de conceitos do dbt usando os dados da Northwind.

### Usando o projeto

Para iniciar o projeto você vai precisar ter o dbt instalado no seu computador conforme as instruções neste [link](https://docs.getdbt.com/docs/installation) ou utilizando o [dbt cloud](https://cloud.getdbt.com/).

Você deverá configurar um *profile* para o seu DW adicionando o seguinte trecho de código no arquivo `~/.dbt/profiles.yml` (lembre-se de alterar as variáveis específicas para seu projeto):

```yaml
northwind:
  outputs:
    dev:
      dataset: northwind
      job_execution_timeout_seconds: 300
      job_retries: 1
      keyfile: path/to/keyfile.json
      location: US
      method: service-account
      priority: interactive
      project: <project_id>
      threads: 1
      type: bigquery
```

Em seguida, teste se a configuração está correta:

```bash
dbt debug

(...)
  Connection test: [OK connection ok]

All checks passed!
```

E adicione os dados no DW usando o `seed` (em geral esses dados já estarão disponíveis no DW através do processo de ingestão, aqui usamos o *seed* para facilitar o início do projeto):

```
dbt seed
```

Pronto! Você deve ter um 

### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
