# 2x RTX 2080Ti NVL-bridge Qwen3.6-27B 78.5t/s on avg (146W powerlimit on each card)

1. git clone https://github.com/snapo/2-x-RTX-2080-Qwen3.6-27B-75.5t-s-avg.git
2. cd 2-x-RTX-2080-Qwen3.6-27B-75.5t-s-avg
3. now edit first the .env file and fill it with the hugginngface token and a api key you decide to use when connecting to your vllm instance
4. open the docker compose file and change the max memory use at the bottom and change in the upper section the port 16384 to a port you like to connect to.
5. after you did edit it, do a "docker compose up --build"
6. Ensure all your coding frameworks are set to 64k context (64k context + 64k output == the ~132k context configured)
7. after you did that, use "docker compose up" (if you like to let it run in the background permanently "docker compose up -d")


Now you have a fully working Qwen3.6 27B model that is extremely fast, and you can use 4 concurrent coding sessions (for example use at the same time 1 opencode session, 1 hermes session, 2 opencode sessions) without one of them influencing another.


Please DO NOT CHANGE SOMETHING ELSE you most probably will break something. This was 1.5 week in the works and was extensive tested to work in : OpenCode , Hermes, Pi Agent, .... many more , i generated approx. 8 million tokens during all the tests and verifications that everything works out of the box.

With this config and nothing changed your llm endpoint/address will be http://myservername:16384/v1 you have to authenticate with the API key you did set in the .env file.


Here are some stats (stats created by LLM Benchy https://github.com/snapo/LLM-Benchy):
```
Benchmark run at 2026-06-13 21:29:10
Model: Qwen3.6 27B
Base URL: http://snabox:16384/v1
Inference engine: vllm
System description (CPU/RAM): Ryzen 3 3600X, 64GB ddr4
System description (GPU): 2 x RTX 2080 Ti with NVLINK, Power limit 146W/card (upgraded 22GB vram each)
Concurrency levels: [1,2,4]
Samples per concurrency multiplier: 1
Temperature: 0.1
Max tokens: 1024

Concurrency = 1
category       samples  avg_prompt_t/s  agg_prompt_t/s  avg_pred_t/s    agg_pred_t/s  avg_latency
-------------- ------- --------------- --------------- ------------- --------------- ------------
coding               1          494.14          494.14         81.67           81.67      12.658s
humanities           1          419.43          419.43         76.21           76.21      13.527s
math                 1          229.68          229.68         74.25           74.25      13.905s
multilingual         1          386.44          386.44         90.22           90.22      11.477s
qa                   1          240.38          240.38         75.76           75.76       8.148s
rag                  1          735.18          735.18         88.98           88.98      11.761s
reasoning            1          231.52          231.52         74.50           74.50      13.857s
roleplay             1          616.02          616.02         69.52           69.52      14.876s
stem                 1          230.50          230.50         72.09           72.09      14.317s
summarization        1          290.94          290.94         81.64           81.64       8.952s
writing              1         1057.05         1057.05         78.78           78.78      14.500s
overall             11          448.30          448.30         78.51           78.51      12.543s

Concurrency = 2
category       samples  avg_prompt_t/s  agg_prompt_t/s  avg_pred_t/s    agg_pred_t/s  avg_latency
-------------- ------- --------------- --------------- ------------- --------------- ------------
coding               2          431.79          863.59         78.95          157.89      13.386s
humanities           2          213.59          427.18         70.28          140.56      14.723s
math                 2          172.36          344.71         71.74          143.48      14.425s
multilingual         2          248.33          496.66         83.50          166.99       8.514s
qa                   2          179.17          358.34         76.74          153.47       8.938s
rag                  2          498.34          996.68         83.12          166.24      12.325s
reasoning            2          236.25          472.50         71.72          143.44      14.404s
roleplay             2          299.19          598.38         74.27          148.55      14.099s
stem                 2          172.64          345.29         71.36          142.72      14.509s
summarization        2          210.78          421.55         76.42          152.84       8.818s
writing              2          514.55         1029.10         72.98          145.96      15.697s
overall             22          288.82          577.64         75.55          151.10      12.713s

Concurrency = 4
category       samples  avg_prompt_t/s  agg_prompt_t/s  avg_pred_t/s    agg_pred_t/s  avg_latency
-------------- ------- --------------- --------------- ------------- --------------- ------------
coding               4          390.68         1562.72         69.49          277.97      15.237s
humanities           4          123.74          494.98         62.71          250.85      16.566s
math                 4          138.33          553.33         60.09          240.34      17.292s
multilingual         4          173.30          693.19         76.31          305.24       8.599s
qa                   4           97.02          388.08         65.61          262.44      13.087s
rag                  4          249.77          999.08         74.33          297.33      12.376s
reasoning            4          114.94          459.77         61.48          245.91      16.883s
roleplay             4          190.39          761.57         63.54          254.16      16.229s
stem                 4          114.90          459.62         60.29          241.15      17.214s
summarization        4          143.37          573.48         65.03          260.14      10.352s
writing              4          251.37         1005.48         63.67          254.70      18.147s
overall             44          180.71          722.85         65.69          262.75      14.726s

```
