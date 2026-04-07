# data-raw/pinyin_lookup.R
# Builds the pinyin_lookup named character vector and saves it to R/sysdata.rda.
# Run: source("data-raw/pinyin_lookup.R")
#
# Format: key   = first 2 Chinese characters of region name as it appears in data
#         value = English romanization, first letter capitalised, no underscores,
#                 no administrative-unit suffixes (市/省/区 already excluded by
#                 taking only the first 2 characters)

library(here)
load(here("R", "sysdata.rda"))  # loads: corruption, region_data

pinyin_lookup <- c(

  # =========================================================================
  # PROVINCES, MUNICIPALITIES, AUTONOMOUS REGIONS, SARs, TAIWAN
  # =========================================================================
  "北京" = "Beijing",
  "天津" = "Tianjin",
  "上海" = "Shanghai",
  "重庆" = "Chongqing",
  "河北" = "Hebei",
  "山西" = "Shanxi",          # NOT Shaanxi
  "辽宁" = "Liaoning",
  "吉林" = "Jilin",
  "黑龙" = "Heilongjiang",    # 黑龙江
  "江苏" = "Jiangsu",
  "浙江" = "Zhejiang",
  "安徽" = "Anhui",
  "福建" = "Fujian",
  "江西" = "Jiangxi",
  "山东" = "Shandong",
  "河南" = "Henan",
  "湖北" = "Hubei",
  "湖南" = "Hunan",
  "广东" = "Guangdong",
  "海南" = "Hainan",
  "四川" = "Sichuan",
  "贵州" = "Guizhou",
  "云南" = "Yunnan",
  "陕西" = "Shaanxi",         # SPECIAL: Shaanxi ≠ Shanxi
  "甘肃" = "Gansu",
  "青海" = "Qinghai",
  "内蒙" = "Inner Mongolia",  # 内蒙古
  "广西" = "Guangxi",
  "西藏" = "Tibet",
  "宁夏" = "Ningxia",
  "新疆" = "Xinjiang",
  "香港" = "Hong Kong",
  "澳门" = "Macao",
  "台湾" = "Taiwan",

  # =========================================================================
  # AREA NAMES  (convert_to = "area")
  # =========================================================================
  "华北" = "Huabei",
  "东北" = "Dongbei",
  "华东" = "Huadong",
  "华中" = "Huazhong",
  "华南" = "Huanan",
  "西南" = "Xinan",
  "西北" = "Xibei",

  # =========================================================================
  # PREFECTURE-LEVEL & HISTORICAL CITY / DISTRICT NAMES
  # Key = first 2 Chinese chars of the region name as it appears in the data.
  # =========================================================================

  # --- A ---
  "阿坝" = "Aba",
  "阿城" = "Acheng",
  "阿克" = "Aksu",            # 阿克苏
  "阿勒" = "Altay",           # 阿勒泰
  "阿拉" = "Alxa",            # 阿拉善 (Inner Mongolia)
  "阿里" = "Ngari",           # 西藏阿里
  "安国" = "Anguo",
  "安康" = "Ankang",
  "安庆" = "Anqing",
  "安顺" = "Anshun",
  "安阳" = "Anyang",
  "安岳" = "Anyue",
  "鞍山" = "Anshan",

  # --- B ---
  "巴彦" = "Bayannur",        # 巴彦淖尔
  "巴音" = "Bayingol",        # 巴音郭楞
  "巴中" = "Bazhong",
  "巴南" = "Banan",
  "巴县" = "Baxian",
  "白城" = "Baicheng",
  "白山" = "Baishan",
  "白沙" = "Baisha",
  "白银" = "Baiyin",
  "百色" = "Baise",
  "保定" = "Baoding",
  "保亭" = "Baoting",
  "保山" = "Baoshan",
  "宝坻" = "Baodi",
  "宝鸡" = "Baoji",
  "宝山" = "Baoshan",
  "北安" = "Beian",
  "北碚" = "Beibei",
  "北辰" = "Beichen",
  "北海" = "Beihai",
  "北郊" = "Beijiao",
  "北票" = "Beipiao",
  "本溪" = "Benxi",
  "毕节" = "Bijie",
  "璧山" = "Bishan",
  "滨海" = "Binhai",
  "滨州" = "Binzhou",
  "亳州" = "Bozhou",
  "博尔" = "Bortala",         # 博尔塔拉
  "泊头" = "Botou",

  # --- C ---
  "沧州" = "Cangzhou",
  "巢湖" = "Chaohu",
  "朝阳" = "Chaoyang",
  "潮州" = "Chaozhou",
  "潮阳" = "Chaoyang",
  "承德" = "Chengde",
  "成都" = "Chengdu",
  "澄海" = "Chenghai",
  "澄迈" = "Chengmai",
  "城口" = "Chengkou",
  "赤峰" = "Chifeng",
  "崇庆" = "Chongzhou",       # old name for 崇州
  "崇文" = "Chongwen",
  "崇明" = "Chongming",
  "崇州" = "Chongzhou",
  "崇左" = "Chongzuo",
  "川沙" = "Chuansha",
  "楚雄" = "Chuxiong",
  "滁县" = "Chuzhou",
  "滁州" = "Chuzhou",
  "从化" = "Conghua",

  # --- D ---
  "大安" = "Daan",
  "大港" = "Dagang",
  "大渡" = "Dadukou",         # 大渡口
  "大庆" = "Daqing",
  "大石" = "Dashiqiao",       # 大石桥
  "大同" = "Datong",
  "大理" = "Dali",
  "大连" = "Dalian",
  "大兴" = "Daxing",
  "大庸" = "Dayong",          # old name for 张家界
  "大足" = "Dazu",
  "儋县" = "Danxian",
  "儋州" = "Danzhou",
  "丹东" = "Dandong",
  "丹棱" = "Danling",
  "丹江" = "Danjiangkou",     # 丹江口
  "当阳" = "Dangyang",
  "达川" = "Dazhou",
  "达县" = "Dazhou",
  "达州" = "Dazhou",
  "大庸" = "Dayong",
  "德宏" = "Dehong",
  "德惠" = "Dehui",
  "德阳" = "Deyang",
  "德州" = "Dezhou",
  "德兴" = "Dexing",
  "定安" = "Dingan",
  "定西" = "Dingxi",
  "定州" = "Dingzhou",
  "迪庆" = "Diqing",
  "东川" = "Dongchuan",
  "东城" = "Dongcheng",
  "东方" = "Dongfang",
  "东港" = "Donggang",
  "东胜" = "Dongsheng",
  "东丽" = "Dongli",
  "东郊" = "Dongjiao",
  "东莞" = "Dongguan",
  "东营" = "Dongying",
  "东至" = "Dongzhi",
  "都江" = "Dujiangyan",      # 都江堰
  "渡口" = "Dukou",           # old name for 攀枝花
  "垫江" = "Dianjiang",

  # --- E ---
  "恩平" = "Enping",
  "恩施" = "Enshi",
  "鄂尔" = "Ordos",           # 鄂尔多斯
  "鄂西" = "Enshi",           # 鄂西土家族苗族自治州 → now 恩施
  "鄂州" = "Ezhou",
  "峨眉" = "Emeishan",        # 峨眉山

  # --- F ---
  "防城" = "Fangchenggang",   # 防城港
  "房山" = "Fangshan",
  "丰都" = "Fengdu",
  "丰南" = "Fengnan",
  "丰城" = "Fengcheng",
  "丰台" = "Fengtai",
  "凤城" = "Fengcheng",
  "奉节" = "Fengjie",
  "奉贤" = "Fengxian",
  "佛山" = "Foshan",
  "涪陵" = "Fuling",
  "抚顺" = "Fushun",
  "抚州" = "Fuzhou",
  "福清" = "Fuqing",
  "福州" = "Fuzhou",
  "富锦" = "Fujin",
  "阜新" = "Fuxin",
  "阜阳" = "Fuyang",

  # --- G ---
  "盖州" = "Gaizhou",
  "甘南" = "Gannan",
  "甘孜" = "Garze",
  "赣州" = "Ganzhou",
  "高安" = "Gaoan",
  "高碑" = "Gaobeidian",      # 高碑店
  "高明" = "Gaoming",
  "高要" = "Gaoyao",
  "高州" = "Gaozhou",
  "藁城" = "Gaocheng",
  "公主" = "Gongzhuling",     # 公主岭
  "共青" = "Gongqingcheng",   # 共青城
  "果洛" = "Golog",
  "广安" = "Guangan",
  "广德" = "Guangde",
  "广汉" = "Guanghan",
  "广州" = "Guangzhou",
  "广元" = "Guangyuan",
  "贵池" = "Guichi",          # old name for 池州
  "贵港" = "Guigang",
  "贵阳" = "Guiyang",
  "固原" = "Guyuan",
  "灌县" = "Dujiangyan",      # old name for 都江堰

  # --- H ---
  "哈密" = "Hami",
  "哈尔" = "Harbin",          # 哈尔滨
  "海北" = "Haibei",
  "海城" = "Haicheng",
  "海东" = "Haidong",
  "海淀" = "Haidian",
  "海拉" = "Hailar",          # 海拉尔
  "海林" = "Hailin",
  "海口" = "Haikou",
  "海西" = "Haixi",
  "汉沽" = "Hangu",
  "汉中" = "Hanzhong",
  "邯郸" = "Handan",
  "鹤壁" = "Hebi",
  "鹤岗" = "Hegang",
  "鹤山" = "Heshan",
  "合川" = "Hechuan",
  "合肥" = "Hefei",
  "贺州" = "Hezhou",
  "和平" = "Heping",
  "和田" = "Hotan",
  "河东" = "Hedong",
  "河间" = "Hejian",
  "河池" = "Hechi",
  "河源" = "Heyuan",
  "河西" = "Hexi",
  "衡水" = "Hengshui",
  "衡阳" = "Hengyang",
  "恒水" = "Hengshui",        # variant spelling if present
  "黑河" = "Heihe",
  "呼伦" = "Hulunbuir",       # 呼伦贝尔
  "呼和" = "Hohhot",          # 呼和浩特
  "虹口" = "Hongkou",
  "红桥" = "Hongqiao",
  "红河" = "Honghe",
  "洪雅" = "Hongya",
  "花都" = "Huadu",
  "淮安" = "Huaian",
  "淮北" = "Huaibei",
  "淮南" = "Huainan",
  "怀化" = "Huaihua",
  "怀柔" = "Huairou",
  "桦甸" = "Huadian",
  "化州" = "Huazhou",
  "华蓥" = "Huaying",
  "黄冈" = "Huanggang",
  "黄骅" = "Huanghua",
  "黄南" = "Huangnan",
  "黄浦" = "Huangpu",
  "黄山" = "Huangshan",
  "黄石" = "Huangshi",
  "黄州" = "Huangzhou",
  "惠民" = "Huimin",
  "惠州" = "Huizhou",
  "惠阳" = "Huiyang",
  "霍林" = "Huolinguole",     # 霍林郭勒
  "徽州" = "Huizhou",         # historical Anhui
  "浑江" = "Hunjiang",        # old name for 白山
  "湖州" = "Huzhou",

  # --- I ---
  "伊犁" = "Yili",
  "伊克" = "Yikezhao",        # 伊克昭盟 (historical Inner Mongolia)
  "伊春" = "Yichun",

  # --- J ---
  "佳木" = "Jiamusi",         # 佳木斯
  "嘉定" = "Jiading",
  "嘉峪" = "Jiayuguan",       # 嘉峪关
  "嘉兴" = "Jiaxing",
  "吉安" = "Jian",
  "集安" = "Jian",
  "集宁" = "Jining",          # historical Inner Mongolia (now 乌兰察布)
  "蛟河" = "Jiaohe",
  "焦作" = "Jiaozuo",
  "揭阳" = "Jieyang",
  "界首" = "Jieshou",
  "金昌" = "Jinchang",
  "金华" = "Jinhua",
  "金山" = "Jinshan",
  "晋城" = "Jincheng",
  "晋江" = "Jinjiang",
  "晋中" = "Jinzhong",
  "晋州" = "Jinzhou",
  "静安" = "Jingan",
  "静海" = "Jinghai",
  "景德" = "Jingdezhen",      # 景德镇
  "镜泊" = "Jingbo",
  "荆门" = "Jingmen",
  "荆沙" = "Jingzhou",        # brief name for 荆州
  "荆州" = "Jingzhou",
  "井冈" = "Jinggangshan",    # 井冈山
  "济南" = "Jinan",
  "济宁" = "Jining",
  "蓟县" = "Jizhou",
  "蓟州" = "Jizhou",
  "建瓯" = "Jianou",
  "建阳" = "Jianyang",
  "简阳" = "Jianyang",
  "江北" = "Jiangbei",
  "江津" = "Jiangjin",
  "江门" = "Jiangmen",
  "江陵" = "Jiangling",
  "江油" = "Jiangyou",
  "九江" = "Jiujiang",
  "九台" = "Jiutai",
  "九龙" = "Jiulong",
  "酒泉" = "Jiuquan",
  "锦州" = "Jinzhou",
  "锦西" = "Huludao",         # old name for 葫芦岛

  # --- K ---
  "开封" = "Kaifeng",
  "开平" = "Kaiping",
  "开原" = "Kaiyuan",
  "开县" = "Kaizhou",         # now 开州
  "开远" = "Kaiyuan",
  "喀什" = "Kashgar",
  "克孜" = "Kizilsu",         # 克孜勒苏
  "克拉" = "Karamay",         # 克拉玛依

  # --- L ---
  "来宾" = "Laibin",
  "莱芜" = "Laiwu",
  "廊坊" = "Langfang",
  "阆中" = "Langzhong",
  "拉萨" = "Lhasa",
  "乐昌" = "Lechang",
  "乐东" = "Ledong",
  "乐平" = "Leping",
  "乐山" = "Leshan",
  "乐至" = "Lezhi",
  "雷州" = "Leizhou",
  "梁平" = "Liangping",
  "凉山" = "Liangshan",
  "廉江" = "Lianjiang",
  "连云" = "Lianyungang",     # 连云港
  "连州" = "Lianzhou",
  "林芝" = "Nyingchi",
  "临沧" = "Lincang",
  "临高" = "Lingao",
  "临河" = "Linhe",
  "临江" = "Linjiang",
  "临沂" = "Linyi",
  "临汾" = "Linfen",
  "临夏" = "Linxia",
  "凌海" = "Linghai",
  "凌源" = "Lingyuan",
  "零陵" = "Lingling",        # old name for 永州
  "陵水" = "Lingshui",
  "邻水" = "Linshui",
  "丽江" = "Lijiang",
  "丽水" = "Lishui",
  "柳州" = "Liuzhou",
  "六盘" = "Liupanshui",      # 六盘水
  "六安" = "Luan",
  "辽源" = "Liaoyuan",
  "辽阳" = "Liaoyang",
  "聊城" = "Liaocheng",
  "龙海" = "Longhai",
  "龙岩" = "Longyan",
  "陇南" = "Longnan",
  "娄底" = "Loudi",
  "鹿泉" = "Luquan",
  "六安" = "Luan",
  "卢湾" = "Luwan",
  "泸州" = "Luzhou",
  "吕梁" = "Luliang",
  "洛阳" = "Luoyang",
  "漯河" = "Luohe",
  "庐山" = "Lushan",

  # --- M ---
  "马鞍" = "Maanshan",        # 马鞍山
  "茂名" = "Maoming",
  "梅河" = "Meihekou",        # 梅河口
  "梅县" = "Meixian",
  "梅州" = "Meizhou",
  "眉山" = "Meishan",
  "密山" = "Mishan",
  "密云" = "Miyun",
  "绵阳" = "Mianyang",
  "闵行" = "Minhang",
  "牡丹" = "Mudanjiang",      # 牡丹江

  # --- N ---
  "那曲" = "Nagqu",
  "南安" = "Nanan",
  "南岸" = "Nanan",
  "南昌" = "Nanchang",
  "南充" = "Nanchong",
  "南川" = "Nanchuan",
  "南宫" = "Nangong",
  "南汇" = "Nanhui",
  "南海" = "Nanhai",
  "南江" = "Nanjiang",
  "南开" = "Nankai",
  "南康" = "Nankang",
  "南京" = "Nanjing",
  "南郊" = "Nanjiao",
  "南宁" = "Nanning",
  "南平" = "Nanping",
  "南市" = "Nanshi",
  "南桐" = "Nantong",
  "南通" = "Nantong",
  "南阳" = "Nanyang",
  "内江" = "Neijiang",
  "讷河" = "Nehe",
  "宁安" = "Ningan",
  "宁波" = "Ningbo",
  "宁德" = "Ningde",
  "宁国" = "Ningguo",
  "宁河" = "Ninghe",
  "怒江" = "Nujiang",

  # --- O ---
  # (no entries starting with O in Chinese administrative names used here)

  # --- P ---
  "盘锦" = "Panjin",
  "番禺" = "Panyu",
  "攀枝" = "Panzhihua",       # 攀枝花
  "彭山" = "Pengshan",
  "彭水" = "Pengshui",
  "彭县" = "Pengzhou",        # old name for 彭州
  "彭州" = "Pengzhou",
  "平昌" = "Pingchang",
  "平顶" = "Pingdingshan",    # 平顶山
  "平谷" = "Pinggu",
  "平凉" = "Pingliang",
  "萍乡" = "Pingxiang",
  "普兰" = "Pulan",
  "普宁" = "Puning",
  "普洱" = "Puer",
  "普陀" = "Putuo",
  "濮阳" = "Puyang",
  "莆田" = "Putian",
  "浦东" = "Pudong",

  # --- Q ---
  "七台" = "Qitaihe",         # 七台河
  "黔东" = "Qiandongnan",     # 黔东南
  "黔江" = "Qianjiang",
  "黔南" = "Qiannan",
  "黔西" = "Qianxinan",       # 黔西南
  "潜江" = "Qianjiang",
  "潜山" = "Qianshan",
  "钦州" = "Qinzhou",
  "秦皇" = "Qinhuangdao",     # 秦皇岛
  "青岛" = "Qingdao",
  "青浦" = "Qingpu",
  "青阳" = "Qingyang",
  "庆阳" = "Qingyang",
  "清远" = "Qingyuan",
  "琼海" = "Qionghai",
  "琼山" = "Qiongshan",
  "琼中" = "Qiongzhong",
  "邛崃" = "Qionglai",
  "曲靖" = "Qujing",
  "泉州" = "Quanzhou",
  "衢州" = "Quzhou",
  "齐齐" = "Qiqihar",         # 齐齐哈尔

  # --- R ---
  "仁寿" = "Renshou",
  "任丘" = "Renqiu",
  "日喀" = "Shigatse",        # 日喀则
  "日照" = "Rizhao",
  "瑞昌" = "Ruichang",
  "瑞金" = "Ruijin",
  "荣昌" = "Rongchang",
  "罗定" = "Luoding",

  # --- S ---
  "三河" = "Sanhe",
  "三明" = "Sanming",
  "三门" = "Sanmenxia",       # 三门峡
  "三沙" = "Sansha",
  "三水" = "Sanshui",
  "三亚" = "Sanya",
  "沙河" = "Shahe",
  "沙坪" = "Shapingba",       # 沙坪坝
  "沙市" = "Shashi",
  "邵武" = "Shaowu",
  "邵阳" = "Shaoyang",
  "绍兴" = "Shaoxing",
  "韶关" = "Shaoguan",
  "深圳" = "Shenzhen",
  "神农" = "Shennongjia",     # 神农架
  "沈阳" = "Shenyang",
  "石家" = "Shijiazhuang",    # 石家庄
  "石景" = "Shijingshan",     # 石景山
  "石柱" = "Shizhu",
  "石狮" = "Shishi",
  "石台" = "Shitai",
  "石嘴" = "Shizuishan",      # 石嘴山
  "四会" = "Sihui",
  "四平" = "Siping",
  "思茅" = "Simao",           # old name for 普洱
  "舒兰" = "Shulan",
  "双桥" = "Shuangqiao",
  "双鸭" = "Shuangyashan",    # 双鸭山
  "朔州" = "Shuozhou",
  "松花" = "Songhuajiang",    # 松花江 (historical Jilin)
  "松江" = "Songjiang",
  "松原" = "Songyuan",
  "遂宁" = "Suining",
  "随州" = "Suizhou",
  "绥化" = "Suihua",
  "绥芬" = "Suifenhe",        # 绥芬河
  "宿迁" = "Suqian",
  "宿县" = "Suzhou",          # old name for 宿州
  "宿州" = "Suzhou",          # Anhui (diff. chars from 苏州 Suzhou, Jiangsu)
  "苏州" = "Suzhou",          # Jiangsu

  # --- T ---
  "塔城" = "Tacheng",
  "泰安" = "Taian",
  "泰州" = "Taizhou",         # Jiangsu
  "台山" = "Taishan",
  "台州" = "Taizhou",         # Zhejiang
  "唐山" = "Tangshan",
  "塘沽" = "Tanggu",
  "天长" = "Tianchang",
  "天门" = "Tianmen",
  "天水" = "Tianshui",
  "铁法" = "Tiefa",
  "铁力" = "Tieli",
  "铁岭" = "Tieling",
  "同江" = "Tongjiang",
  "铜仁" = "Tongren",
  "铜川" = "Tongchuan",
  "铜梁" = "Tongliang",
  "铜陵" = "Tongling",
  "通化" = "Tonghua",
  "通江" = "Tongjiang",
  "通辽" = "Tongliao",
  "通什" = "Wuzhishan",       # old name for 五指山, Hainan
  "通县" = "Tongzhou",        # old name for 通州
  "通州" = "Tongzhou",
  "潼南" = "Tongnan",
  "屯昌" = "Tunchang",
  "屯溪" = "Tunxi",           # now part of 黄山
  "吐鲁" = "Turpan",          # 吐鲁番

  # --- U ---
  "乌海" = "Wuhai",
  "乌兰" = "Ulanqab",         # 乌兰察布
  "乌鲁" = "Urumqi",          # 乌鲁木齐

  # --- W ---
  "瓦房" = "Wafangdian",      # 瓦房店
  "万宁" = "Wanning",
  "万盛" = "Wansheng",
  "万县" = "Wanxian",
  "万源" = "Wanyuan",
  "万州" = "Wanzhou",
  "威海" = "Weihai",
  "渭南" = "Weinan",
  "潍坊" = "Weifang",
  "文昌" = "Wenchang",
  "文山" = "Wenshan",
  "温州" = "Wenzhou",
  "武安" = "Wuan",
  "武汉" = "Wuhan",
  "武隆" = "Wulong",
  "武清" = "Wuqing",
  "武胜" = "Wusheng",
  "武威" = "Wuwei",
  "武夷" = "Wuyishan",        # 武夷山
  "巫山" = "Wushan",
  "巫溪" = "Wuxi",
  "无为" = "Wuwei",
  "无锡" = "Wuxi",
  "梧州" = "Wuzhou",
  "吴川" = "Wuchuan",
  "吴淞" = "Wusong",
  "吴忠" = "Wuzhong",
  "五大" = "Wudalianchi",     # 五大连池
  "五指" = "Wuzhishan",       # 五指山

  # --- X ---
  "厦门" = "Xiamen",
  "咸宁" = "Xianning",
  "咸阳" = "Xianyang",
  "仙桃" = "Xiantao",
  "西安" = "Xian",
  "西城" = "Xicheng",
  "西郊" = "Xijiao",
  "西宁" = "Xining",
  "西青" = "Xiqing",
  "西双" = "Xishuangbanna",   # 西双版纳
  "湘潭" = "Xiangtan",
  "湘西" = "Xiangxi",
  "襄樊" = "Xiangyang",       # old name for 襄阳
  "襄阳" = "Xiangyang",
  "孝感" = "Xiaogan",
  "信阳" = "Xinyang",
  "新会" = "Xinhui",
  "新乐" = "Xinle",
  "新民" = "Xinmin",
  "新乡" = "Xinxiang",
  "新余" = "Xinyu",
  "兴安" = "Xingan",
  "兴城" = "Xingcheng",
  "兴宁" = "Xingning",
  "邢台" = "Xingtai",
  "辛集" = "Xinji",
  "秀山" = "Xiushan",
  "许昌" = "Xuchang",
  "宣城" = "Xuancheng",
  "宣武" = "Xuanwu",
  "徐汇" = "Xuhui",
  "徐州" = "Xuzhou",

  # --- Y ---
  "雅安" = "Yaan",
  "雁北" = "Yanbei",          # historical Shanxi region
  "延安" = "Yanan",
  "延边" = "Yanbian",
  "延庆" = "Yanqing",
  "烟台" = "Yantai",
  "盐城" = "Yancheng",
  "扬州" = "Yangzhou",
  "杨浦" = "Yangpu",
  "阳春" = "Yangchun",
  "阳江" = "Yangjiang",
  "阳泉" = "Yangquan",
  "宜宾" = "Yibin",
  "宜昌" = "Yichang",
  "宜春" = "Yichun",
  "宜都" = "Yidu",
  "益阳" = "Yiyang",
  "银川" = "Yinchuan",
  "银南" = "Yinnan",          # old Ningxia region
  "营口" = "Yingkou",
  "鹰潭" = "Yingtan",
  "英德" = "Yingde",
  "永安" = "Yongan",
  "永川" = "Yongchuan",
  "永州" = "Yongzhou",
  "玉林" = "Yulin",           # Guangxi
  "玉树" = "Yushu",           # Qinghai
  "玉溪" = "Yuxi",
  "榆林" = "Yulin",           # Shaanxi
  "榆树" = "Yushu",           # Jilin
  "云浮" = "Yunfu",
  "云阳" = "Yunyang",
  "运城" = "Yuncheng",
  "郧阳" = "Yunyang",         # Hubei
  "渝北" = "Yubei",
  "渝中" = "Yuzhong",
  "岳池" = "Yuechi",
  "岳阳" = "Yueyang",
  "酉阳" = "Youyang",

  # --- Z ---
  "枣庄" = "Zaozhuang",
  "增城" = "Zengcheng",
  "闸北" = "Zhabei",
  "湛江" = "Zhanjiang",
  "张家" = "Zhangjiakou",     # 张家口
  "张掖" = "Zhangye",
  "漳州" = "Zhangzhou",
  "樟树" = "Zhangshu",
  "赵庆" = "Zhaoqing",        # variant if present
  "肇庆" = "Zhaoqing",
  "哲里" = "Zhelimu",         # historical Inner Mongolia
  "浙江" = "Zhejiang",
  "镇江" = "Zhenjiang",
  "郑州" = "Zhengzhou",
  "郴州" = "Chenzhou",
  "周口" = "Zhoukou",
  "舟山" = "Zhoushan",
  "珠海" = "Zhuhai",
  "株洲" = "Zhuzhou",
  "庄河" = "Zhuanghe",
  "涿州" = "Zhuozhou",
  "自贡" = "Zigong",
  "淄博" = "Zibo",
  "资阳" = "Ziyang",
  "綦江" = "Qijiang",
  "遵化" = "Zunhua",
  "遵义" = "Zunyi",
  "邛崃" = "Qionglai",

  # --- Additional entries discovered from validation ---
  "门头" = "Mentougou",       # 门头沟 (Beijing district)
  "昌平" = "Changping",       # Beijing district
  "顺义" = "Shunyi",          # Beijing district
  "包头" = "Baotou",          # Inner Mongolia
  "锡林" = "Xilingol",        # 锡林郭勒 (Inner Mongolia)
  "长春" = "Changchun",       # Jilin
  "鸡西" = "Jixi",            # Heilongjiang
  "芜湖" = "Wuhu",            # Anhui
  "蚌埠" = "Bengbu",          # Anhui
  "池州" = "Chizhou",         # Anhui
  "商丘" = "Shangqiu",        # Henan
  "驻马" = "Zhumadian",       # 驻马店 (Henan)
  "十堰" = "Shiyan",          # Hubei
  "汕头" = "Shantou",         # Guangdong
  "汕尾" = "Shanwei",         # Guangdong
  "中山" = "Zhongshan",       # Guangdong
  "顺德" = "Shunde",          # Guangdong (now part of Foshan)
  "桂林" = "Guilin",          # Guangxi
  "上饶" = "Shangrao",        # Jiangxi
  "昌都" = "Chamdo",          # Tibet
  "山南" = "Shannan",         # Tibet
  "长寿" = "Changshou",       # Chongqing
  "忠县" = "Zhongxian",       # Chongqing
  "常州" = "Changzhou",       # Jiangsu
  "杭州" = "Hangzhou",        # Zhejiang
  "菏泽" = "Heze",            # Shandong
  "太原" = "Taiyuan",         # Shanxi
  "长治" = "Changzhi",        # Shanxi
  "忻州" = "Xinzhou",         # Shanxi
  "兰州" = "Lanzhou",         # Gansu
  "商洛" = "Shangluo",        # Shaanxi
  "昌吉" = "Changji",         # Xinjiang
  "昆明" = "Kunming",         # Yunnan
  "昭通" = "Zhaotong",        # Yunnan
  "长沙" = "Changsha",        # Hunan
  "常德" = "Changde",         # Hunan
  "长宁" = "Changning",       # Shanghai district / Sichuan
  "昌江" = "Changjiang",      # Hainan
  "枝城" = "Zhicheng",        # old Hubei (now part of Yichang)
  "市中" = "Shizhong",        # district name (multiple cities)
  "霸州" = "Bazhou",          # Hebei
  "津南" = "Jinnan",          # Tianjin district
  "洮南" = "Taonan",          # Jilin
  "葫芦" = "Huludao",         # 葫芦岛 (Liaoning)
  "长乐" = "Changle",         # Fujian
  "中卫" = "Zhongwei"         # Ningxia
)

# =========================================================================
# VALIDATION: check that every 2-char key from the actual data is covered
# =========================================================================
name_cols  <- grep("^[0-9]{4}_name$",  names(region_data), value = TRUE)
sname_cols <- grep("^[0-9]{4}_sname$", names(region_data), value = TRUE)
prov_cols  <- grep("^prov_(name|sname)$", names(region_data), value = TRUE)
all_names  <- unique(unlist(lapply(c(name_cols, sname_cols, prov_cols),
                                   function(col) region_data[[col]])))
data_keys  <- unique(substr(all_names[!is.na(all_names)], 1, 2))
missing    <- data_keys[!data_keys %in% names(pinyin_lookup)]
if (length(missing) > 0) {
  warning("Missing keys in pinyin_lookup (", length(missing), "):\n",
          paste(missing, collapse = ", "))
} else {
  message("All ", length(data_keys), " data keys are covered.")
}

# =========================================================================
# SAVE to sysdata.rda alongside existing objects
# =========================================================================
save(corruption, region_data, pinyin_lookup,
    file = here("R", "sysdata.rda"),
    compress = "bzip2")
message("pinyin_lookup saved with ", length(pinyin_lookup), " entries.")
