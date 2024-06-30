#!/bin/sh
# 下载规则
curl -o i-1.txt https://adguardteam.github.io/HostlistsRegistry/assets/filter_29.txt
curl -o i-2.txt https://adguardteam.github.io/HostlistsRegistry/assets/filter_21.txt
curl -o i-3.txt https://raw.githubusercontent.com/TG-Twilight/AWAvenue-Ads-Rule/main/Filters/AWAvenue-Ads-Rule-Clash.yaml
curl -o i-4.txthttps://ghproxy.net/https://raw.githubusercontent.com/banbendalao/ADgk/master/ADgk.txt
curl -o i-5.txt https://ghproxy.net/https://raw.githubusercontent.com/damengzhu/banad/main/jiekouAD.txt
curl -o i-6.txt https://ghproxy.net/https://raw.githubusercontent.com/afwfv/DD-AD/main/rule/DD-AD.txt
curl -o i-7.txt https://www.xlxbk.cn/dns.txt
curl -o i-8.txt https://raw.githubusercontent.com/5-whys/adh-rules/main/rules/output_medium.txt
# 合并规则并去除重复项
cat i*.txt > i-mergd.txt
cat i-mergd.txt | grep -v '^!' | grep -v '^！' | grep -v '^# ' | grep -v '^# ' | grep -v '^\[' | grep -v '^\【' > i-tmpp.txt
sort -n i-tmpp.txt | uniq > i-tmp.txt

python rule.py i-tmp.txt

# 计算规则数
num=`cat i-tmp.txt | wc -l`

# 添加标题和时间
echo "[Adblock Plus 2.0]" >> i-tpdate.txt
echo "! Title: ABP Merge Rules" >> i-tpdate.txt
echo "! Description: 该规则合并自jiekouAD，AdGuard中文语言规则，AdGuard移动横幅广告过滤器，AdGuard URL跟踪过滤器，EasyList no Element Rules，乘风视频广告过滤规则，EasylistChina，ChinaList+EasyList(修正)，EasylistLite，CJX'sAnnoyance，Adblock Warning Removal List以及补充的一些规则" >> i-tpdate.txt
echo "! Homepage: https://github.com/damengzhu/abpmerge" >> i-tpdate.txt
echo "! Version: `date +"%Y-%m-%d %H:%M:%S"`" >> i-tpdate.txt
echo "! Total count: $num" >> i-tpdate.txt
cat i-tpdate.txt i-tmp.txt > abpmerge.txt

cat "abpmerge.txt" | grep \
-e "\(^\|\w\)#@\?#" \
-e "\(^\|\w\)#@\??#" \
-e "\(^\|\w\)#@\?\$#" \
-e "\(^\|\w\)#@\?\$?#" \
> "CSSRule.txt"

# 从 https://filters.adtidy.org/android/filters/2_optimized.txt 下载规则文件
# 移除包含 # 或 generichide 的行，然后生成 easylistnocssrule.txt 的修改版本到当前工作目录。

# 获取规则文件并将其存储在内存中
EASYLIST=$(wget -q -O - https://filters.adtidy.org/android/filters/2_optimized.txt)

# 移除包含 # 或 generichide 的行
echo "$EASYLIST" | grep -v "#" | grep -v "generichide" > sccheng.txt

# 将 EasyListnoElementRules.txt 复制到存储库中
cp sccheng.txt /path/to/repository/


# 删除缓存
rm i-*.txt

#退出程序
exit

