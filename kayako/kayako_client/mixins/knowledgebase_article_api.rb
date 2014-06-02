#######################################################################
#
# Kayako Ruby REST API library
# _____________________________________________________________________
#
# @author      Andriy Lesyuk
#
# @package     KayakoClient
# @copyright   Copyright (c) 2011-2013, Kayako
# @license     FreeBSD
# @link        https://github.com/kayako/ruby-api-library
#
#######################################################################

module KayakoClient
    module KnowledgebaseArticleAPI

        def self.included(base)
            base.extend(ClassMethods)
        end

        def delete_request(options = {})
            raise RuntimeError, "undefined article ID" unless kb_article_id
            raise RuntimeError, "undefined ID" unless id
            super(options.merge(:e => "#{self.class.path}/#{kb_article_id}/#{id}"))
        end

        module ClassMethods

            def all(article, options = {})
                unless article.to_i > 0
                    logger.error "invalid :kb_article_id - #{article}" if logger
                    raise ArgumentError, "invalid article ID"
                end
                super(options.merge(:e => "#{path}/ListAll/#{article.to_i}"))
            end

            def get(article, id, options = {})
                unless article.to_i > 0
                    logger.error "invalid :kb_article_id - #{article}" if logger
                    raise ArgumentError, "invalid article ID"
                end
                if id == :all
                    all(article, options)
                else
                    unless id.to_i > 0
                        logger.error "invalid :id - #{id}" if logger
                        raise ArgumentError, "invalid ID"
                    end
                    super(id, options.merge(:e => "#{path}/#{article.to_i}/#{id.to_i}"))
                end
            end

            def delete(article, id, options = {})
                unless article.to_i > 0
                    logger.error "invalid :kb_article_id - #{article}" if logger
                    raise ArgumentError, "invalid article ID"
                end
                unless id.to_i > 0
                    logger.error "invalid :id - #{id}" if logger
                    raise ArgumentError, "invalid ID"
                end
                super(id, options.merge(:e => "#{path}/#{article.to_i}/#{id.to_i}"))
            end

        end

    end
end
