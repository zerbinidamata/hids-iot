
# https://github.com/elastic/logstash-docker
FROM docker.elastic.co/logstash/logstash-oss:7.13.2

RUN logstash-plugin install logstash-filter-json
RUN logstash-plugin install logstash-filter-i18n
RUN logstash-plugin install logstash-filter-json_encode
RUN logstash-plugin install logstash-filter-geoip