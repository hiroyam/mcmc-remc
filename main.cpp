#include "./util.hpp"

using namespace cc;

float gauss_kernel(float x, float temperature) {
    float inverse_temperature = 1.0f / temperature;

    auto multimordal_gauss = [](float x) -> float {
            return std::exp(-std::pow(x - 10, 2) / 2.0f) / std::sqrt(2.0f * M_PI) +
                   std::exp(-std::pow(x + 10, 2) / 2.0f) / std::sqrt(2.0f * M_PI);
        };
    return std::pow(multimordal_gauss(x), inverse_temperature);
}

int main(int argc, char *argv[]) {
    try {
        vec_t     samples;
        const int n_loop = 1000000;
        int       accept = 0;

        // 温度の違う系を複数用意する
        const int n_systems = 3;
        vec_t     t {-10.0f, -10.0f, -10.0f};
        vec_t     temperatures {1.0f, 10.0f, 100.0f};

        for (int i = 0; i < n_loop; i++) {
            // それぞれの系で独立にMCMCを行う
            for (int j = 0; j < n_systems; j++) {
                // ランダムウォークMH法
                float a = t[j] + uniform_rand(-5.0f, 5.0f);
                float r = gauss_kernel(a, temperatures[j]) / gauss_kernel(t[j], temperatures[j]);

                if (std::min(1.0f, r) > uniform_rand(0.0f, 1.0f)) {
                    accept++;
                    t[j] = a;
                }
            }
            // 必要なのはT=1.0の系列だけ
            samples.push_back(t[0]);

            // 適当なステップ毎にランダムに選んだ系について確率min(1,r)で状態を交換する
            const int exchange_freq = 1;
            if (i % exchange_freq == 0) {
                int   j  = uniform_rand(0, 1);                         // 0<->1 or 1<->2
                float nu = gauss_kernel(t[j], temperatures[j + 1]) * gauss_kernel(t[j + 1], temperatures[j]);
                float de = gauss_kernel(t[j], temperatures[j])   * gauss_kernel(t[j + 1], temperatures[j + 1]);
                float r  = nu / de;
                if (std::min(1.0f, r) > uniform_rand(0.0f, 1.0f)) {
                    std::swap(t[j], t[j + 1]);
                }
            }
        }

        // 受容率を調べる
        std::cout << format_str("persec: %.1f%%", 100.0f * accept / samples.size()) << std::endl;

        // バーンイン期間を破棄する
        const int n_burnin = samples.size() / 10;
        std::rotate(samples.begin(), samples.begin() + n_burnin, samples.end());
        samples.resize(samples.size() - n_burnin);

        // EAP推定値を求める
        float mean = std::accumulate(samples.begin(), samples.end(), 0.0f) / samples.size();
        std::cout << format_str("mean: %f", mean) << std::endl;

        float var = 0.0f;
        for (auto v : samples) {
            var += std::pow((v - mean), 2) / samples.size();
        }
        std::cout << format_str("variance: %f", var) << std::endl;

        // プロットする
        std::ofstream ofs("output");
        for (auto v : samples) {
            ofs << format_str("%f", v) << std::endl;
        }

        // // 自己相関を計算する
        // vec_t correlations(50);
        // for (size_t k = 0; k < correlations.size(); k++) {
        //     for (size_t i = 0; i < samples.size() / 2; i++) {
        //         correlations[k] += (samples[i] - mean) * (samples[i + k] - mean) / (samples.size() / 2) / var;
        //     }
        // }
        // std::ofstream ofs("output");
        // for (auto v : correlations) {
        //     ofs << format_str("%f", v) << std::endl;
        // }
    } catch (const std::exception &e) {
        std::cerr << colorant('y', format_str("error: %s", e.what())) << std::endl;
    }
}
