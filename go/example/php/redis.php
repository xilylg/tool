<?php

function getRedis() {
    $start = microtime(true);
    for($i=0; $i<1; $i++) {
        $redis = new Redis();
        $redis->connect('127.0.0.1', 6379);
        $result = $redis->hgetall("tmp_hash");
        $redis->close();
    }
    echo microtime(true) - $start;
}

function getBaidu() {
    $start = microtime(true);
//     for ($i=0; $i<10; $i++) {
        $ch = curl_init();
        
        // set url
        curl_setopt($ch, CURLOPT_URL, "www.baidu.com");
        
        //return the transfer as a string
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        
        // $output contains the output string
        $output = curl_exec($ch);
        
        // close curl resource to free up system resources
        curl_close($ch);     
//     }
    echo (microtime(true) - $start)."\n";
}

getRedis();
