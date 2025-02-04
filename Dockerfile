# syntax = docker/dockerfile:1

# Definição da versão do Ruby (mantenha igual ao seu Gemfile e .ruby-version)
ARG RUBY_VERSION=2.7.2
FROM ruby:$RUBY_VERSION-slim as base

# Diretório de trabalho
WORKDIR /rails

# Definição do ambiente para desenvolvimento
ENV RAILS_ENV="development" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT=""

# Etapa de build para instalar dependências necessárias
FROM base as build

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential git libpq-dev pkg-config curl && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Copia os arquivos de dependências antes do código-fonte para otimizar cache
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copia o código da aplicação
COPY . .

# Finalizando o container da aplicação
FROM base

# Instalar pacotes mínimos necessários
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y curl && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Copia as dependências e código compilado do estágio anterior
COPY --from=build /usr/local/bundle /usr/local/bundle
COPY --from=build /rails /rails

# Permissão para usuário não-root
RUN useradd rails --create-home --shell /bin/bash && \
    chown -R rails:rails log tmp
USER rails:rails

# Definir entrada para preparar o ambiente antes de rodar o servidor
ENTRYPOINT ["/rails/bin/docker-entrypoint"]

# Expõe a porta do servidor Rails
EXPOSE 3000

# Comando padrão ao iniciar o container
CMD ["./bin/rails", "server", "-b", "0.0.0.0"]
