<?php

/**
 * 1. В конструктор передается только кэш, но не передается логер, либо нужно передавать оба объекта, либо ни одного
 * Я убрал из метода конструктора параметр кэша, создал новый метод для установки кэша
 * Теперь можно инициализировать так:
 * $provider = new src\Decorator\DecoratorManager($host, $user, $password)->setLogger($logger)->setCache($cache)->.....
 *
 * Метод конструктора убрал
 *
 * Сообщение об ошибке не информативное, добавил вывод самой ошибки
 *
 * Декоратор тут не нужен вовсе
 */


namespace src\Decorator;

use DateTime;
use Exception;
use Psr\Cache\CacheItemPoolInterface;
use Psr\Log\LoggerInterface;
use src\Integration\DataProvider;

class DecoratorManager extends DataProvider
{
    /**
     * @var CacheItemPoolInterface
     */
    public $cache;

    /**
     * @var LoggerInterface
     */
    public $logger;

    public function setLogger(LoggerInterface $logger)
    {
        $this->logger = $logger;
        return $this;
    }

    public function setCache(CacheItemPoolInterface $cache)
    {
        $this->cache = $cache;
        return $this;
    }

    /**
     * {@inheritdoc}
     */
    public function getResponse(array $input)
    {
        try {
            $cacheKey = $this->getCacheKey($input);
            $cacheItem = $this->cache->getItem($cacheKey);
            if ($cacheItem->isHit()) {
                return $cacheItem->get();
            }

            $result = parent::get($input);

            $cacheItem
                ->set($result)
                ->expiresAt(
                    (new DateTime())->modify('+1 day')
                );

            return $result;
        } catch (Exception $e) {
            $this->logger->critical('Error: ' . $e->getMessage());
        }

        return [];
    }

    public function getCacheKey(array $input)
    {
        return json_encode($input);
    }
}
