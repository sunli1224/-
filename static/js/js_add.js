/ *！
 * jQuery Validation Plugin v1.17.0
 *
 * https://jqueryvalidation.org/
 *
 *版权所有（c）2017 J？rn Zaefferer
 *根据MIT许可证发布
 * /
（功能（工厂）{
	if（typeof define ===“function”&& define.amd）{
		define（[“jquery”，“./ jquery.validate”]，factory）;
	} else if（typeof module ===“object”&& module.exports）{
		module.exports = factory（require（“jquery”））;
	} else {
		工厂（jQuery）;
	}
}（function（$）{

（function（）{

	function stripHtml（value）{

		//删除html标签和空间字符
		return value.replace（/<。[^ <>] *？> / g，“”）.replace（/＆nbsp; |＆＃160; / gi，“”）

		//删除标点符号
		.replace（/ [。（）,;:!?%# $'，“/ + = \ / \  - ”，“*”/“g”，“”）;
	}

	$ .validator.addMethod（“maxWords”，function（value，element，params）{
		返回this.optional（元素）|| stripHtml（value）.match（/ \ b \ w + \ b / g）.length <= params;
	}，$ .validator.format（“请输入{0}字或更少。”））;

	$ .validator.addMethod（“minWords”，function（value，element，params）{
		返回this.optional（元素）|| stripHtml（value）.match（/ \ b \ w + \ b / g）.length> = params;
	}，$ .validator.format（“请输入至少{0}个单词。”））;

	$ .validator.addMethod（“rangeWords”，function（value，element，params）{
		var valueStripped = stripHtml（value），
			正则表达式= / \ b \ w + \ b / g;
		返回this.optional（元素）|| valueStripped.match（regex）.length> = params [0] && valueStripped.match（regex）。length <= params [1];
	}，$ .validator.format（“请输入{0}和{1}个单词。”））;

}（））;

//根据所需的mimetype接受文件输入中的值
$ .validator.addMethod（“accept”，function（value，element，param）{

	//在逗号上拆分mime，以防我们有多种类型可以接受
	var typeParam = typeof param ===“string”？param.replace（/ \ s / g，“”）：“image / *”，
		optionalValue = this.optional（element），
		我，档案，正则表达式;

	//元素是可选的
	if（optionalValue）{
		return optionalValue;
	}

	if（$（element）.attr（“type”）===“file”）{

		//在正则表达式中使用的转义字符串
		//参见：https：//stackoverflow.com/questions/3446170/escape-string-for-use-in-javascript-regex
		//将“/ *”转义为“/.*”作为通配符
		typeParam = typeParam
				.replace（/[--\[\] \ /\\\\\\\\\\\\\\\\\\\\\\\\\|] / g，“\\ $＆”）
				.replace（/，/ g，“|”）
				.replace（/ \ / \ * / g，“/。*”）;

		//在检查每个文件之前检查元素是否具有FileList
		if（element.files && element.files.length）{
			regex = new RegExp（“。？（”+ typeParam +“）$”，“i”）;
			for（i = 0; i <element.files.length; i ++）{
				file = element.files [i];

				//从加载的文件中获取mimetype，验证它是否匹配
				if（！file.type.match（regex））{
					返回虚假;
				}
			}
		}
	}

	//要么返回true，因为我们已经验证了每个文件，要么是因为
	//浏览器不支持element.files和FileList功能
	返回true;
}，$ .validator.format（“请输入一个有效的mimetype值。”））;

$ .validator.addMethod（“alphanumeric”，function（value，element）{
	返回this.optional（元素）|| / ^ \ w + $ / i.test（value）;
}，“请来信件，数字和下划线”）;

/ *
 *荷兰银行帐号（不是'giro'号码）有9位数字
 *并通过'11检查'。
 *我们接受带空格的符号，因为这很常见。
 *可接受：123456789或12 34 56 789
 * /
$ .validator.addMethod（“bankaccountNL”，function（value，element）{
	if（this.optional（element））{
		返回true;
	}
	if（！（/ ^ [0-9] {9} |（[0-9] {2}）{3} [0-9] {3} $ / .test（value）））{
		返回虚假;
	}

	//现在'11检查'
	var account = value.replace（/ / g，“”），//删除空格
		sum = 0，
		len = account.length，
		pos，factor，digit;
	for（pos = 0; pos <len; pos ++）{
		factor = len  -  pos;
		digit = account.substring（pos，pos + 1）;
		sum = sum + factor * digit;
	}
	返回总和％11 === 0;
}，“请指定有效的银行帐号”）;

$ .validator.addMethod（“bankorgiroaccountNL”，function（value，element）{
	返回this.optional（元素）||
			（$ .validator.methods.bankaccountNL.call（this，value，element））||
			（$ .validator.methods.giroaccountNL.call（this，value，element））;
}，“请指定有效的银行或转帐帐号”）;

/ **
 * BIC是业务标识符代码（ISO 9362）。此BIC检查不是真实性的保证。
 *
 * BIC模式：BBBBCCLLbbb（8或11个字符长; bbb是可选的）
 *
 *验证不区分大小写。请确保自己标准化输入。
 *
 * BIC详细定义：
 *  - 前4个字符 - 银行代码（仅限字母）
 *  - 接下来的2个字符 -  ISO 3166-1 alpha-2国家代码（仅限字母）
 *  - 接下来的2个字符 - 位置代码（字母和数字）
 * 一个。不得以'0'或'1'开头
 * b。第二个字符必须是字母（不允许'O'）或数字（'0'表示测试（因此不允许），'1'表示被动参与者，'2'表示反向计费）
 *  - 最后3个字符 - 分支代码，可选（除非主办公室为'XXX'，否则不得以'X'开头）（字母和数字）
 * /
$ .validator.addMethod（“bic”，function（value，element）{
    返回this.optional（元素）|| / ^（[AZ] {6} [A-Z2-9] [A-NP-Z1-9]）（X {3} | [A-WY-Z0-9] [A-Z0-9] {2- }）？$ / .test（value.toUpperCase（））;
}，“请指定有效的BIC代码”）;

/ *
 * C trade digo de identificaci贸易财政（CIF）是西班牙法人实体的税务识别代码
 *更多规则可以在西班牙语http://es.wikipedia.org/wiki/C%C3%B3digo_de_identificaci%C3%B3n_fiscal找到
 *
 *西班牙语CIF结构：
 *
 * [T] [P] [P] [N] [N] [N] [N] [N] [C]
 *
 *地点：
 *
 * T：1个字符。组织函件：[ABCDEFGHJKLMNPQRSUVW]
 * P：2个字符。省。
 * N：5个字符。省内的Secuencial数字。
 * C：1个字符。控制位：[0-9A-J]。
 *
 * [T]：组织类型。可能的值：
 *
 * A.公司
 * B.有限责任公司
 * C.一般伙伴关系
 * D.公司有限合伙
 * E.货物的社区
 * F.合作社
 * G.协会
 * H.横向财产制度中的房主社区
 * J.民间社会
 * K.旧格式
 * L.旧格式
 * M.旧格式
 * N.非居民实体
 * P.地方当局
 *问：自治机构，州与否等，以及会众和宗教机构
 * R.会众和宗教机构（自2008年起订购EHA / 451/2008）
 *国家行政和地区的S.器官
 * V.土地改造
 * W.西班牙非居民的常设机构
 *
 * [C]：控制数字。根据T值，它可以是数字或字母：
 * [T]  - > [C]
 * ------ ----------
 * 一个号码
 * B号码
 * E号码
 * H号码
 * K信
 * P信
 * Q信
 * S信
 *
 * /
$ .validator.addMethod（“cifES”，function（value，element）{
	“严格使用”;

	if（this.optional（element））{
		返回true;
	}

	var cifRegEx = new RegExp（/ ^（[ABCDEFGHJKLMNPQRSUVW]）（\ d {7}）（[0-9A-J]）$ / gi）;
	var letter = value.substring（0,1），// [T]
		number = value.substring（1,8），// [P] [P] [N] [N] [N] [N] [N]
		control = value.substring（8,9），// [C]
		all_sum = 0，
		even_sum = 0，
		odd_sum = 0，
		我，n，
		control_digit，
		control_letter;

	function isOdd（n）{
		返回n％2 === 0;
	}

	//快速格式测试
	if（value.length！== 9 ||！cifRegEx.test（value））{
		返回虚假;
	}

	for（i = 0; i <number.length; i ++）{
		n = parseInt（number [i]，10）;

		//奇怪的位置
		if（isOdd（i））{

			//奇数位置首先成倍增加。
			n * = 2;

			//如果乘法大于10，我们需要调整
			odd_sum + = n <10？n：n  -  9;

		//甚至是职位
		//总结一下
		} else {
			even_sum + = n;
		}
	}

	all_sum = even_sum + odd_sum;
	control_digit =（10  - （all_sum）.toString（）。substr（-1））。toString（）;
	control_digit = parseInt（control_digit，10）> 9？“0”：control_digit;
	control_letter =“JABCDEFGHI”.substr（control_digit，1）.toString（）;

	//控制必须是一个数字
	if（letter.match（/ [ABEH] /））{
		return control === control_digit;

	//控制必须是一个字母
	} else if（letter.match（/ [KPQS] /））{
		返回控制=== control_letter;
	}

	//也可以
	返回控制=== control_digit || control === control_letter;

}，“请指定有效的CIF编号。” ）;

/ *
 * Brazillian公积金号码（Cadastrado de Pessoas F铆sicas）相当于巴西税务登记号码。
 * CPF编号总共有11位数字：9个数字后跟2个用于验证的校验码。
 * /
$ .validator.addMethod（“cpfBR”，function（value）{

	//从值中删除特殊字符
	value = value.replace（/（[?] @# $％^＆*（）_ + ='{} \ [\ \ \ \ \ \ \ | \ | \：;'<>，。\ /？]）+ / g ，“”）;

	//检查值只有11位数
	if（value.length！== 11）{
		返回虚假;
	}

	var sum = 0，
		firstCN，secondCN，checkResult，i;

	firstCN = parseInt（value.substring（9,10），10）;
	secondCN = parseInt（value.substring（10,11），10）;

	checkResult = function（sum，cn）{
		var result =（sum * 10）％11;
		if（（result === 10）||（result === 11））{
			result = 0;
		}
		return（结果=== cn）;
	};

	//检查转储数据
	if（value ===“”||
		值===“00000000000”||
		值===“11111111111”||
		值===“22222222222”||
		值===“33333333333”||
		值===“44444444444”||
		值===“55555555555”||
		值===“66666666666”||
		值===“77777777777”||
		值===“88888888888”||
		值===“99999999999”
	）{
		返回虚假;
	}

	//第1步 - 使用第一个支票号码：
	for（i = 1; i <= 9; i ++）{
		sum = sum + parseInt（value.substring（i-1，i），10）*（11-i）;
	}

	//如果第一个支票号码（CN）有效，请转到步骤2  - 使用第二个支票号码：
	if（checkResult（sum，firstCN））{
		sum = 0;
		for（i = 1; i <= 10; i ++）{
			sum = sum + parseInt（value.substring（i-1，i），10）*（12-i）;
		}
		return checkResult（sum，secondCN）;
	}
	返回虚假;

}，“请指定有效的公积金号码”）;

// https://jqueryvalidation.org/creditcard-method/
//基于https://en.wikipedia.org/wiki/Luhn_algorithm
$ .validator.addMethod（“creditcard”，function（value，element）{
	if（this.optional（element））{
		返回“依赖性不匹配”;
	}

	//只接受空格，数字和短划线
	if（/ [^ 0-9 \  - ] + /.test（value））{
		返回虚假;
	}

	var nCheck = 0，
		nDigit = 0，
		bEven = false，
		n，cDigit;

	value = value.replace（/ \ D / g，“”）;

	//基于最小和最大长度
	// https://developer.ean.com/general_info/Valid_Credit_Card_Types
	if（value.length <13 || value.length> 19）{
		返回虚假;
	}

	for（n = value.length  -  1; n> = 0; n--）{
		cDigit = value.charAt（n）;
		nDigit = parseInt（cDigit，10）;
		if（bEven）{
			if（（nDigit * = 2）> 9）{
				nDigit  -  = 9;
			}
		}

		nCheck + = nDigit;
		bEven =！bEven;
	}

	return（nCheck％10）=== 0;
}， “请输入一个有效的信用卡号码。” ）;

/ *注意：Castle.Components.Validator.CreditCardValidator的修改版本
 *在Apache许可证2.0下重新分发，网址为http://www.apache.org/licenses/LICENSE-2.0
 *有效类型：万事达卡，签证，美国运通卡，dinersclub，途中，发现，jcb，未知，全部（覆盖所有其他设置）
 * /
$ .validator.addMethod（“creditcardtypes”，function（value，element，param）{
	if（/ [^ 0-9 \  - ] + /.test（value））{
		返回虚假;
	}

	value = value.replace（/ \ D / g，“”）;

	var validTypes = 0x0000;

	if（param.mastercard）{
		validTypes | = 0x0001;
	}
	if（param.visa）{
		validTypes | = 0x0002;
	}
	if（param.amex）{
		validTypes | = 0x0004;
	}
	if（param.dinersclub）{
		validTypes | = 0x0008;
	}
	if（param.enroute）{
		validTypes | = 0x0010;
	}
	if（param.discover）{
		validTypes | = 0x0020;
	}
	if（param.jcb）{
		validTypes | = 0x0040;
	}
	if（param.unknown）{
		validTypes | = 0x0080;
	}
	if（param.all）{
		validTypes = 0x0001 | 0x0002 | 0x0004 | 0x0008 | 0x0010 | 0x0020 | 0x0040 | 0x0080;
	}
	if（validTypes＆0x0001 && / ^（5 [12345]）/。test（value））{//万事达卡
		return value.length === 16;
	}
	if（validTypes＆0x0002 && / ^（4）/。test（value））{// Visa
		return value.length === 16;
	}
	if（validTypes＆0x0004 && / ^（3 [47]）/。test（value））{// Amex
		return value.length === 15;
	}
	if（validTypes＆0x0008 && / ^（3（0 [012345] | [68]））/。test（value））{// Dinersclub
		return value.length === 14;
	}
	if（validTypes＆0x0010 && / ^（2（014 | 149））/。test（value））{// Enroute
		return value.length === 15;
	}
	if（validTypes＆0x0020 && / ^（6011）/ .test（value））{//发现
		return value.length === 16;
	}
	if（validTypes＆0x0040 && / ^（3）/。test（value））{// Jcb
		return value.length === 16;
	}
	if（validTypes＆0x0040 && / ^（2131 | 1800）/ .test（value））{// Jcb
		return value.length === 15;
	}
	if（validTypes＆0x0080）{//未知
		返回true;
	}
	返回虚假;
}， “请输入一个有效的信用卡号码。” ）;

/ **
 *通过@jameslouiz验证任何给定符号的货币
 *符号可以是可选的或必需的。默认情况下需要符号
 *
 *用法示例：
 * currency：[“拢”，false]  - 使用false进行软货币验证
 *货币：[“$”，false]
 * currency：[“RM”，false]  - 也适用于基于文本的符号，例如“RM” - 马来西亚林吉特等
 *
 * <input class =“currencyInput”name =“currencyInput”>
 *
 *软符号检查
 * currencyInput：{
 *货币：[“$”，false]
 *}
 *
 *严格的符号检查（默认）
 * currencyInput：{
 *货币：“$”
 * //要么
 *货币：[“$”，true]
 *}
 *
 *多个符号
 * currencyInput：{
 *货币：“$，拢，垄”
 *}
 * /
$ .validator.addMethod（“currency”，function（value，element，param）{
    var isParamString = typeof param ===“string”，
        symbol = isParamString？param：param [0]，
        soft = isParamString？true：param [1]，
        正则表达式;

    symbol = symbol.replace（/，/ g，“”）;
    符号=柔软？symbol +“]”：symbol +“]？”;
    regex =“^ [”+ symbol +“（[1-9] {1} [0-9] {0,2}（\\，[0-9] {3}）*（\\。[0- 9] {0,2}）|？[1-9] {1} [0-9] {0，}（\\ [0-9] {0,2}）|。？0（\\ [。 0-9] {0,2}）|（\\ [0-9] {1,2}））$“？？;
    regex = new RegExp（正则表达式）;
    返回this.optional（元素）|| regex.test（value）;

}，“请指定有效货币”）;

$ .validator.addMethod（“dateFA”，function（value，element）{
	返回this.optional（元素）|| / ^ [1-4] \ d {3} \ /（（0 [1-6] \ /（（3 [0-1]）|？（[1-2] [0-9]）|（0 ？[1-9]）））|（（1 [0-2] |（0 [7-9]））\ /（30 |？（[1-2] [0-9]）|（0＆le [1-9]））））$ / .test（value）;
}，$ .validator.messages.date）;

/ **
 *如果值是有效日期，则返回true，也进行正式检查dd / mm / yyyy。
 *
 * @example $ .validator.methods.date（“01/01/1900”）
 * @result是的
 *
 * @example $ .validator.methods.date（“01/13/1990”）
 * @result false
 *
 * @example $ .validator.methods.date（“01.01.1900”）
 * @result false
 *
 * @example <input name =“pippo”class =“{dateITA：true}”/>
 * @desc声明一个可选的输入元素，其值必须是有效日期。
 *
 * @name $ .validator.methods.dateITA
 * @type布尔值
 * @cat插件/验证/方法
 * /
$ .validator.addMethod（“dateITA”，function（value，element）{
	var check = false，
		re = / ^ \ d {1,2} \ / \ d {1,2} \ / \ d {4} $ /，
		adata，gg，mm，aaaa，xdata;
	if（re.test（value））{
		adata = value.split（“/”）;
		gg = parseInt（adata [0]，10）;
		mm = parseInt（adata [1]，10）;
		aaaa = parseInt（adata [2]，10）;
		xdata = new Date（Date.UTC（aaaa，mm  -  1，gg，12,0,0,0））;
		if（（xdata.getUTCFullYear（）=== aaaa）&&（xdata.getUTCMonth（）=== mm  -  1）&&（xdata.getUTCDate（）=== gg））{
			check = true;
		} else {
			check = false;
		}
	} else {
		check = false;
	}
	返回this.optional（元素）|| 校验;
}，$ .validator.messages.date）;

$ .validator.addMethod（“dateNL”，function（value，element）{
	返回this.optional（元素）|| / ^（0 [1-9] | [12] \ d | 3 [01]）[\ \ / \  - ]（0 [1-9] |λ1 [012]）。[\ \ / \ - ]（[12] \ d）？（\ d \ d）$ / .test（value）;
}，$ .validator.messages.date）;

//较旧的“接受”文件扩展名方法。旧文档：http：//docs.jquery.com/Plugins/Validation/Methods/accept
$ .validator.addMethod（“extension”，function（value，element，param）{
	param = typeof param ===“string”？param.replace（/，/ g，“|”）：“png | jpe？g | gif”;
	返回this.optional（元素）|| value.match（new RegExp（“\\。（”+ param +“）$”，“i”））;
}，$ .validator.format（“请输入一个有效扩展名的值。”））;

/ **
 *荷兰转帐帐号（非银行号码）最多7位数
 * /
$ .validator.addMethod（“giroaccountNL”，function（value，element）{
	返回this.optional（元素）|| / ^ [0-9] {1,7} $ / .test（value）;
}，“请指定有效的转帐帐号”）;

/ **
 * IBAN是国际银行帐号。
 *它具有特定国家/地区的格式，也在此处进行检查
 *
 *验证不区分大小写。请确保自己标准化输入。
 * /
$ .validator.addMethod（“iban”，function（value，element）{

	//一些快速简单的测试，以防止不必要的工作
	if（this.optional（element））{
		返回true;
	}

	//删除空格和大写
	var iban = value.replace（/ / g，“”）。toUpperCase（），
		ibancheckdigits =“”，
		leadingZeroes = true，
		cRest =“”，
		cOperator =“”，
		countrycode，ibancheck，charAt，cChar，bbanpattern，bbancountrypatterns，ibanregexp，i，p;

	//检查IBAN代码长度。
	// 它包含：
	//国家代码ISO 3166-1  - 两个字母，
	//两个校验位，
	//基本银行帐号（BBAN） - 最多30个字符
	var minimalIBANlength = 5;
	if（iban.length <minimalIBANlength）{
		返回虚假;
	}

	//检查国家/地区代码并查找特定国家/地区的格式
	countrycode = iban.substring（0,2）;
	bbancountrypatterns = {
		“AL”：“\\ d {8} [\\ dA-Z] {16}”，
		“AD”：“\\ d {8} [\\ dA-Z] {12}”，
		“AT”：“\\ d {16}”，
		“AZ”：“[\\ dA-Z] {4} \\ d {20}”，
		“BE”：“\\ d {12}”，
		“BH”：“[AZ] {4} [\\ dA-Z] {14}”，
		“BA”：“\\ d {16}”，
		“BR”：“\\ d {23} [AZ] [\\ dA-Z]”，
		“BG”：“[AZ] {4} \\ d {6} [\\ dA-Z] {8}”，
		“CR”：“\\ d {17}”，
		“HR”：“\\ d {17}”，
		“CY”：“\\ d {8} [\\ dA-Z] {16}”，
		“CZ”：“\\ d {20}”，
		“DK”：“\\ d {14}”，
		“DO”：“[AZ] {4} \\ d {20}”，
		“EE”：“\\ d {16}”，
		“FO”：“\\ d {14}”，
		“FI”：“\\ d {14}”，
		“FR”：“\\ d {10} [\\ dA-Z] {11} \\ d {2}”，
		“GE”：“[\\ dA-Z] {2} \\ d {16}”，
		“DE”：“\\ d {18}”，
		“GI”：“[AZ] {4} [\\ dA-Z] {15}”，
		“GR”：“\\ d {7} [\\ dA-Z] {16}”，
		“GL”：“\\ d {14}”，
		“GT”：“[\\ dA-Z] {4} [\\ dA-Z] {20}”，
		“HU”：“\\ d {24}”，
		“是”：“\\ d {22}”，
		“IE”：“[\\ dA-Z] {4} \\ d {14}”，
		“IL”：“\\ d {19}”，
		“IT”：“[AZ] \\ d {10} [\\ dA-Z] {12}”，
		“KZ”：“\\ d {3} [\\ dA-Z] {13}”，
		“KW”：“[AZ] {4} [\\ dA-Z] {22}”，
		“LV”：“[AZ] {4} [\\ dA-Z] {13}”，
		“LB”：“\\ d {4} [\\ dA-Z] {20}”，
		“LI”：“\\ d {5} [\\ dA-Z] {12}”，
		“LT”：“\\ d {16}”，
		“LU”：“\\ d {3} [\\ dA-Z] {13}”，
		“MK”：“\\ d {3} [\\ dA-Z] {10} \\ d {2}”，
		“MT”：“[AZ] {4} \\ d {5} [\\ dA-Z] {18}”，
		“MR”：“\\ d {23}”，
		“MU”：“[AZ] {4} \\ d {19} [AZ] {3}”，
		“MC”：“\\ d {10} [\\ dA-Z] {11} \\ d {2}”，
		“MD”：“[\\ dA-Z] {2} \\ d {18}”，
		“我”：“\\ d {18}”，
		“NL”：“[AZ] {4} \\ d {10}”，
		“不”：“\\ d {11}”，
		“PK”：“[\\ dA-Z] {4} \\ d {16}”，
		“PS”：“[\\ dA-Z] {4} \\ d {21}”，
		“PL”：“\\ d {24}”，
		“PT”：“\\ d {21}”，
		“RO”：“[AZ] {4} [\\ dA-Z] {16}”，
		“SM”：“[AZ] \\ d {10} [\\ dA-Z] {12}”，
		“SA”：“\\ d {2} [\\ dA-Z] {18}”，
		“RS”：“\\ d {18}”，
		“SK”：“\\ d {20}”，
		“SI”：“\\ d {15}”，
		“ES”：“\\ d {20}”，
		“SE”：“\\ d {20}”，
		“CH”：“\\ d {5} [\\ dA-Z] {12}”，
		“TN”：“\\ d {20}”，
		“TR”：“\\ d {5} [\\ dA-Z] {17}”，
		“AE”：“\\ d {3} \\ d {16}”，
		“GB”：“[AZ] {4} \\ d {14}”，
		“VG”：“[\\ dA-Z] {4} \\ d {16}”
	};

	bbanpattern = bbancountrypatterns [countrycode];

	//因为新的国家将开始使用IBAN
	// future，我们只检查国家代码是否已知。
	//这可以防止误报，而几乎所有
	//由此引入的误报将被捕获
	//无论如何都是通过下面的校验和验证。
	//对于未知，严格检查应该返回FALSE
	//国家
	if（typeof bbanpattern！==“undefined”）{
		ibanregexp = new RegExp（“^ [AZ] {2} \\ d {2}”+ bbanpattern +“$”，“”）;
		if（！（ibanregexp.test（iban）））{
			返回虚假; //国家/地区特定格式无效
		}
	}

	//现在检查校验和，首先转换为数字
	ibancheck = iban.substring（4，iban.length）+ iban.substring（0,4）;
	for（i = 0; i <ibancheck.length; i ++）{
		charAt = ibancheck.charAt（i）;
		if（charAt！==“0”）{
			leadingZeroes = false;
		}
		if（！leadingZeroes）{
			ibancheckdigits + =“0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ”.indexOf（charAt）;
		}
	}

	//计算结果：ibancheckdigits％97
	for（p = 0; p <ibancheckdigits.length; p ++）{
		cChar = ibancheckdigits.charAt（p）;
		cOperator =“”+ cRest +“”+ cChar;
		cRest = cOperator％97;
	}
	return cRest === 1;
}，“请指定有效的IBAN”）;

$ .validator.addMethod（“integer”，function（value，element）{
	返回this.optional（元素）|| / ^  - ？\ d + $ / .test（value）;
}，“请给出正数或负数非十进制数”）;

$ .validator.addMethod（“ipv4”，function（value，element）{
	返回this.optional（元素）|| /^(25[0-5]|2[0-4]\d|[01]?\d\d?)\.(25[0-5]|2[0-4]\d|[01 ] \ d \ d）\（25 [0-5] |？2 [0-4] \ d | [01] \ d \ d）\（25 [0-5] |？2 [0 -4] \ d | [01]？\ d \ d？）$ / i.test（value）;
}，“请输入有效的IP v4地址。” ）;

$ .validator.addMethod（“ipv6”，function（value，element）{
	返回this.optional（元素）|| / ^（（（[0-9A-发F] {1,4}：）{7} [0-9A-发F] {1,4}）|（（[0-9A-发-F ] {1,4}：）{6}：[0-9A-发F] {1,4}）|（（[0-9A-发F] {1,4}：）{5}： （[0-9A-发F] {1,4}：）？[0-9A-发F] {1,4}）|（（[0-9A-发F] {1,4} ：）{4}：（[0-9A-发F] {1,4}：）{0,2} [0-9A-发F] {1,4}）|（（[0-9A -Fa-F] {1,4}：）{3}：（[0-9A-发F] {1,4}：）{0,3} [0-9A-发F] {1， 4}）|（（[0-9A-发F] {1,4}：）{2}：（[0-9A-发F] {1,4}：）{0,4} [0 -9A发-F] {1,4}）|（（[0-9A-发F] {1,4}：）{6}（（\ b（（25 [0-5]）|（ 1 \ d {2}）|（2 [0-4] \ d）|。（\ d {1,2}））\ b）中\）{3}（\ b（（25 [0-5]） |（1 \ d {2}）|（2 [0-4] \ d）|（\ d {1,2}））\ b））|（（[0-9A-发F] {1， 4}：）{0,5}：（（\ b（（25 [0-5]）|（1 \ d {2}）|（2 [0-4] \ d）|（\ d {1， 2}））\ b）中\）{3}（\ b（（25 [0-5]）|（1 \ d {2}）|（2 [0-4] \ d）|（\ d { 1,2}））\ b））|（::（[0-9A-发F] {1,4}：）{0,5}（（\ b（（25 [0-5]）| （1 \ d {2}）|（2 [0-4] \ d）|。（\ d {1,2}））\ b）中\）{3}（\ b（（25 [0-5] ）|（1 \ d {2}）|（2 [0-4] \ d）|（\ d {1,2}））\ b））|（[0-9A-发F] {1， 4} ::（[0-9A-发F] {1,4}：）{0,5} [0-9A-发F] {1,4}）|（::（[0-9A -Fa-F] {1,4}：）{0，
}，“请输入有效的IP v6地址。” ）;

$ .validator.addMethod（“lettersonly”，function（value，element）{
	返回this.optional（元素）|| / ^ [az] + $ / i.test（value）;
}，“请来信”）;

$ .validator.addMethod（“letterswithbasicpunc”，function（value，element）{
	返回this.optional（元素）|| / ^ [az \  - 。，（）'“\ s] + $ / i.test（value）;
}，“请信件或标点符号”）;

$ .validator.addMethod（“mobileNL”，function（value，element）{
	返回this.optional（元素）|| / ^（（\ + | 00（\ S |？？？？\ S \  -  \ S））31（\ S |？？？？\ S \  -  \ S）（\（0 \）\  -  \ s]的？）？| 0）6（（\ s | \ s？\  -  \ s？）？[0-9]）{8} $ / .test（value）;
}，“请指定有效的手机号码”）;

/ *对于UK手机功能，请执行以下服务器端处理：
 *将原始输入与此RegEx模式进行比较：
 * ^ \（？（？:(？：00 \）？[\ s \  - ]？\（？| \ +）（44）\）？[\ s \  - ]？\（？（？：0 \ ）[\ S \  - ] \（）|？？？？？0）（[1-9] \ d {1,4} \）\ S \ d \  - ] +）$
 *如果$ 1为'44'，则提取$ 1并将$前缀设置为'+44 <space>'，否则将$ prefix设置为'0'
 *提取$ 2并删除连字符，空格和括号。电话号码合并$前缀和$ 2。
 *还可以在以下网址找到许多非常详细的GB电话号码RegEx模式：
 * http://www.aa-asterisk.org.uk/index.php/Regular_Expressions_for_Validating_and_Formatting_GB_Telephone_Numbers
 * /
$ .validator.addMethod（“mobileUK”，function（phone_number，element）{
	phone_number = phone_number.replace（/ \（| \）| \ s + |  -  / g，“”）;
	返回this.optional（元素）|| phone_number.length> 9 &&
		phone_number.match（/ ^（？:(？:( ?: 00 \ s？| \ +）44 \ s？| 0）7（？：[1345789] \ d {2} | 624）\ s？\ d {3} \ s？\ d {3}）$ /）;
}，“请指定有效的手机号码”）;

$ .validator.addMethod（“netmask”，function（value，element）{
    返回this.optional（元素）|| /^(254|252|248|240|224|192|128)\.0\.0\.0|255\.(254|252|248|240|224|192|128|0)\.0 \ 0.0 |。255 \ 0.255 \（254 | 252 | 248 | 240 | 224 | 192 | 128 | 0）\ 0 |。。255 \ 0.255 \ 0.255 \（254 | 252 | 248 | 240 | 224 | 192 | 128 | 0）/i.test（value）;
}，“请输入有效的网络掩码。” ）;

/ *
 * NIE（N Coal mero de Identificaci Trade n de Extranjero）是西班牙语指定的西班牙税号
 *任何外国人的权力。
 *
 * NIE相当于西班牙人N Coal mero de Identificaci Trade n Fiscal（NIF），作为财政
 *识别号码。CIF编号（Certificado de Identificaci贸易财政）等同于NIF，但适用于
 *公司而不是个人。NIE由'X'或'Y'后跟7或8位数字组成，然后是另一个字母。
 * /
$ .validator.addMethod（“nieES”，function（value，element）{
	“严格使用”;

	if（this.optional（element））{
		返回true;
	}

	var nieRegEx = new RegExp（/ ^ [MXYZ] {1} [0-9] {7,8} [TRWAGMYFPDXBNJZSQVHLCKET] {1} $ / gi）;
	var validChars =“TRWAGMYFPDXBNJZSQVHLCKET”，
		letter = value.substr（value.length  -  1）.toUpperCase（），
		数;

	value = value.toString（）。toUpperCase（）;

	//快速格式测试
	if（value.length> 10 || value.length <9 ||！nieRegEx.test（value））{
		返回虚假;
	}

	// X表示相同的数字
	// Y表示数字+ 10000000
	// Z表示数字+ 20000000
	value = value.replace（/ ^ [X] /，“0”）
		.replace（/ ^ [Y] /，“1”）
		.replace（/ ^ [Z] /，“2”）;

	number = value.length === 9？value.substr（0,8）：value.substr（0,9）;

	return validChars.charAt（parseInt（number，10）％23）=== letter;

}，“请指定有效的NIE号码。” ）;

/ *
 * N Coal mero de Identificaci Trade n Fiscal（NIF）是西班牙个人使用的税务识别方式
 * /
$ .validator.addMethod（“nifES”，function（value，element）{
	“严格使用”;

	if（this.optional（element））{
		返回true;
	}

	value = value.toUpperCase（）;

	//基本格式测试
	if（！value.match（“（（^ [AZ] {1} [0-9] {7} [A-Z0-9] {1} $ | ^ [T] {1} [A-Z0-9 ] {8} $）| ^ [0-9] {8} [AZ] {1} $）“））{
		返回虚假;
	}

	//测试NIF
	if（/ ^ [0-9] {8} [AZ] {1} $ /.test（value））{
		return（“TRWAGMYFPDXBNJZSQVHLCKE”.charAt（value.substring（8,0）％23）=== value.charAt（8））;
	}

	//测试特价NIF（以K，L或M开头）
	if（/ ^ [KLM] {1} /.test（value））{
		return（value [8] ===“TRWAGMYFPDXBNJZSQVHLCKE”.charAt（value.substring（8,1）％23））;
	}

	返回虚假;

}，“请指定有效的NIF号码。” ）;

/ *
 * Numer identyfikacji podatkowej（NIP）是波兰公司使用的税务识别方式
 * /
$ .validator.addMethod（“nipPL”，function（value）{
	“严格使用”;

	value = value.replace（/ [^ 0-9] / g，“”）;

	if（value.length！== 10）{
		返回虚假;
	}

	var arrSteps = [6,5,7,2,3,4,5,6,7];
	var intSum = 0;
	for（var i = 0; i <9; i ++）{
		intSum + = arrSteps [i] * value [i];
	}
	var int2 = intSum％11;
	var intControlNr =（int2 === 10）？0：int2;

	return（intControlNr === parseInt（value [9]，10））;
}，“请指定有效的NIP号码。” ）;

$ .validator.addMethod（“notEqualTo”，function（value，element，param）{
	返回this.optional（元素）|| ！$。validator.methods.equalTo.call（this，value，element，param）;
}，“请输入不同的值，值不能相同。” ）;

$ .validator.addMethod（“nowhitespace”，function（value，element）{
	返回this.optional（元素）|| / ^ \ S + $ / i.test（value）;
}，“请不要空格”）;

/ **
*如果字段值与给定格式RegExp匹配，则返回true
*
* @example $ .validator.methods.pattern（“AR1004”，element，/ ^ AR \ d {4} $ /）
* @result是的
*
* @example $ .validator.methods.pattern（“BR1004”，element，/ ^ AR \ d {4} $ /）
* @result false
*
* @name $ .validator.methods.pattern
* @type布尔值
* @cat插件/验证/方法
* /
$ .validator.addMethod（“pattern”，function（value，element，param）{
	if（this.optional（element））{
		返回true;
	}
	if（typeof param ===“string”）{
		param = new RegExp（“^（？：”+ param +“）$”）;
	}
	return param.test（value）;
}， “无效的格式。” ）;

/ **
 *荷兰语电话号码有10位数（或11位，以+31开头）。
 * /
$ .validator.addMethod（“phoneNL”，function（value，element）{
	返回this.optional（元素）|| / ^（（\ + | 00（\ S |？？？？\ S \  -  \ S））31（\ S |？？？？\ S \  -  \ S）（\（0 \）\  -  \ s]的？）？| 0）[1-9]（（\ s | \ s？\  -  \ s？）？[0-9]）{8} $ / .test（value）;
}，“请指定有效的电话号码。” ）;

/ *对于UK手机功能，请执行以下服务器端处理：
 *将原始输入与此RegEx模式进行比较：
 * ^ \（？（？:(？：00 \）？[\ s \  - ]？\（？| \ +）（44）\）？[\ s \  - ]？\（？（？：0 \ ）[\ S \  - ] \（）|？？？？？0）（[1-9] \ d {1,4} \）\ S \ d \  - ] +）$
 *如果$ 1为'44'，则提取$ 1并将$前缀设置为'+44 <space>'，否则将$ prefix设置为'0'
 *提取$ 2并删除连字符，空格和括号。电话号码合并$前缀和$ 2。
 *还可以在以下网址找到许多非常详细的GB电话号码RegEx模式：
 * http://www.aa-asterisk.org.uk/index.php/Regular_Expressions_for_Validating_and_Formatting_GB_Telephone_Numbers
 * /

//匹配英国固定电话+移动电话，仅接受01-3用于固定电话或07用于移动电话以排除许多高级电话号码
$ .validator.addMethod（“phonesUK”，function（phone_number，element）{
	phone_number = phone_number.replace（/ \（| \）| \ s + |  -  / g，“”）;
	返回this.optional（元素）|| phone_number.length> 9 &&
		phone_number.match（/ ^（？:(？:( ?: 00 \ s？| \ +）44 \ s？| 0）（？：1 \ d {8,9} | [23] \ d {9} | 7（？：[1345789] \ d {8} | 624 \ d {6}）））$ /）;
}，“请指定有效的英国电话号码”）;

/ *对于UK手机功能，请执行以下服务器端处理：
 *将原始输入与此RegEx模式进行比较：
 * ^ \（？（？:(？：00 \）？[\ s \  - ]？\（？| \ +）（44）\）？[\ s \  - ]？\（？（？：0 \ ）[\ S \  - ] \（）|？？？？？0）（[1-9] \ d {1,4} \）\ S \ d \  - ] +）$
 *如果$ 1为'44'，则提取$ 1并将$前缀设置为'+44 <space>'，否则将$ prefix设置为'0'
 *提取$ 2并删除连字符，空格和括号。电话号码合并$前缀和$ 2。
 *还可以在以下网址找到许多非常详细的GB电话号码RegEx模式：
 * http://www.aa-asterisk.org.uk/index.php/Regular_Expressions_for_Validating_and_Formatting_GB_Telephone_Numbers
 * /
$ .validator.addMethod（“phoneUK”，function（phone_number，element）{
	phone_number = phone_number.replace（/ \（| \）| \ s + |  -  / g，“”）;
	返回this.optional（元素）|| phone_number.length> 9 &&
		phone_number.match（/ ^（？:(？:( ?: 00 \ s？| \ +）44 \ s？）|（？：\（？0））（？：\ d {2} \）？\ ？的\ d {4} \ S \ d {4} |？\ d {3} \）\ S \ d {3} \ S \ d {3,4} |？？？？\ d {4} \） ？\ s？（？：\ d {5} | \ d {3} \ s？\ d {3}）| \ d {5} \）？\ s？\ d {4,5}）$ /） ;
}，“请指定有效的电话号码”）;

/ **
 *匹配美国电话号码格式
 *
 *区域代码不能以1开头，前缀不能以1开头
 *允许' - '或''作为分隔符，并允许区域代码周围的parens
 *有些人可能想在他们的号码前放一个'1'
 *
 * 1（212）-999-2345或
 * 212 999 2344或
 * 212-999-0983
 *
 * 但不是
 * 111-123-5434
 * 并不是
 * 212 123 4567
 * /
$ .validator.addMethod（“phoneUS”，function（phone_number，element）{
	phone_number = phone_number.replace（/ \ s + / g，“”）;
	返回this.optional（元素）|| phone_number.length> 9 &&
		phone_number.match（/ ^（\ +？1  - ？）？（\（[2-9]（[02-9] \ d | 1 [02-9]）\）| [2-9]（[02 -9] \ d | 1 [02-9]）） - ？[2-9]（[02-9] \ d | 1 [02-9]） - ？\ d {4} $ /）;
}，“请指定有效的电话号码”）;

/ *
* Valida CEPs做brasileiros：
*
* Formatos aceitos：
* 99999-999
* 99.999-999
* 99999999
* /
$ .validator.addMethod（“postalcodeBR”，function（cep_value，element）{
	返回this.optional（元素）|| / ^ \ d {2}。\ d {3}  -  \ d {3}？$ | ^ \ d {5}  - ？\ d {3}？$ /。test（cep_value）;
}，“Informe um CEP v谩lido。” ）;

/ **
 *匹配有效的加拿大邮政编码
 *
 * @example jQuery.validator.methods.postalCodeCA（“H0H 0H0”，element）
 * @result是的
 *
 * @example jQuery.validator.methods.postalCodeCA（“H0H0H0”，element）
 * @result false
 *
 * @name jQuery.validator.methods.postalCodeCA
 * @type布尔值
 * @cat插件/验证/方法
 * /
$ .validator.addMethod（“postalCodeCA”，function（value，element）{
	返回this.optional（元素）|| / ^ [ABCEGHJKLMNPRSTVXY] \ d [ABCEGHJKLMNPRSTVWXYZ] * \ d [ABCEGHJKLMNPRSTVWXYZ] \ d $ / i.test（value）;
}，“请指定有效的邮政编码”）;

/ *匹配意大利邮政编码（CAP）* /
$ .validator.addMethod（“postalcodeIT”，function（value，element）{
	返回this.optional（元素）|| / ^ \ d {5} $ / .test（value）;
}，“请指定有效的邮政编码”）;

$ .validator.addMethod（“postalcodeNL”，function（value，element）{
	返回this.optional（元素）|| / ^ [1-9] [0-9] {3} \ s？[a-zA-Z] {2} $ / .test（value）;
}，“请指定有效的邮政编码”）;

//匹配英国邮政编码。与拥有自己的邮政编码的英国海峡群岛不匹配（非标准英国）
$ .validator.addMethod（“postcodeUK”，function（value，element）{
	返回this.optional（元素）|| / ^（（（[A-PR-UWYZ] [0-9]）|（[A-PR-UWYZ] [0-9] [0-9]）|（[A-PR-UWYZ] [A- HK-Y] [0-9]）|（[A-PR-UWYZ] [A-HK-Y] [0-9] [0-9]）|（[A-PR-UWYZ] [0-9 ] [A-HJKSTUW]）|？（[A-PR-UWYZ] [A-HK-Y] [0-9] [ABEHMNPRVWXY]））\ S（[0-9] [ABD-HJLNP-UW-Z ] {2}）|（GIR）\ s？（0AA））$ / i.test（value）;
}，“请指定有效的英国邮政编码”）;

/ *
 *让您说“至少必须填充与选择器Y匹配的X输入。”
 *
 *最终结果是这些输入都不是：
 *
 * <input class =“productinfo”name =“partnumber”>
 * <input class =“productinfo”name =“description”>
 *
 * ...将验证，除非至少填写其中一个。
 *
 * partnumber：{require_from_group：[1，“。productinfo”]}，
 *说明：{require_from_group：[1，“。productinfo”]}
 *
 * options [0]：必须在组中填写的字段数
 * options [1]：CSS选择器，用于定义条件必需字段组
 * /
$ .validator.addMethod（“require_from_group”，function（value，element，options）{
	var $ fields = $（options [1]，element.form），
		$ fieldsFirst = $ fields.eq（0），
		validator = $ fieldsFirst.data（“valid_req_grp”）？$ fieldsFirst.data（“valid_req_grp”）：$ .extend（{}，this），
		isValid = $ fields.filter（function（）{
			return validator.elementValue（this）;
		}）。length> = options [0];

	//存储克隆的验证器以供将来验证
	$ fieldsFirst.data（“valid_req_grp”，validator）;

	//如果未验证元素，请运行每个require_from_group字段的验证规则
	if（！$（element）.data（“being_validated”））{
		$ fields.data（“being_validated”，true）;
		$ fields.each（function（）{
			validator.element（this）;
		}）;
		$ fields.data（“being_validated”，false）;
	}
	return isValid;
}，$ .validator.format（“请填写这些字段中至少{0}个。”））;

/ *
 *让你说“要么必须填写至少与选择器Y匹配的X输入，
 *或者必须全部跳过（留空）。“
 *
 *最终结果是，这些输入都不是：
 *
 * <input class =“productinfo”name =“partnumber”>
 * <input class =“productinfo”name =“description”>
 * <input class =“productinfo”name =“color”>
 *
 * ...将验证，除非其中至少有两个被填充，
 *或者都不是。
 *
 * partnumber：{skip_or_fill_minimum：[2，“。productinfo”]}，
 *说明：{skip_or_fill_minimum：[2，“。productinfo”]}，
 * color：{skip_or_fill_minimum：[2，“。productinfo”]}
 *
 * options [0]：必须在组中填写的字段数
 * options [1]：CSS选择器，用于定义条件必需字段组
 *
 * /
$ .validator.addMethod（“skip_or_fill_minimum”，function（value，element，options）{
	var $ fields = $（options [1]，element.form），
		$ fieldsFirst = $ fields.eq（0），
		validator = $ fieldsFirst.data（“valid_skip”）？$ fieldsFirst.data（“valid_skip”）：$ .extend（{}，this），
		numberFilled = $ fields.filter（function（）{
			return validator.elementValue（this）;
		} ）。长度，
		isValid = numberFilled === 0 || numberFilled> = options [0];

	//存储克隆的验证器以供将来验证
	$ fieldsFirst.data（“valid_skip”，validator）;

	//如果未验证元素，请运行每个skip_or_fill_minimum字段的验证规则
	if（！$（element）.data（“being_validated”））{
		$ fields.data（“being_validated”，true）;
		$ fields.each（function（）{
			validator.element（this）;
		}）;
		$ fields.data（“being_validated”，false）;
	}
	return isValid;
}，$ .validator.format（“请跳过这些字段或填写至少{0}个。”））;

/ *通过@jdforsythe验证美国和/或地区
 *可以不区分大小写或需要大写 - 默认不区分大小写
 *可以包括美国领土 - 默认不包括
 *可以包括美国军方邮政缩写（AA，AE，AP） - 默认不包括
 *
 *注意：“国家”总是包括DC（哥伦比亚特区）
 *
 *用法示例：
 *
 *这是默认设置 - 不区分大小写，没有区域，没有军区
 * stateInput：{
 * caseSensitive：false，
 * includeTerritories：false，
 * includeMilitary：false
 *}
 *
 *只允许大写字母，没有领土，没有军事区
 * stateInput：{
 * caseSensitive：false
 *}
 *
 *不区分大小写，包括地区但不包括军事区域
 * stateInput：{
 * includeTerritories：true
 *}
 *
 *仅允许大写字母，包括地区和军事区
 * stateInput：{
 * caseSensitive：true，
 * includeTerritories：true，
 * includeMilitary：是的
 *}
 *
 * /
$ .validator.addMethod（“stateUS”，function（value，element，options）{
	var isDefault = typeof options ===“undefined”，
		caseSensitive =（isDefault || typeof options.caseSensitive ===“undefined”）？false：options.caseSensitive，
		includeTerritories =（isDefault || typeof options.includeTerritories ===“undefined”）？false：options.includeTerritories，
		includeMilitary =（isDefault || typeof options.includeMilitary ===“undefined”）？false：options.includeMilitary，
		正则表达式;

	if（！includeTerritories &&！includeMilitary）{
		regex =“^（A [KLRZ] | C [AOT] | D [CE] | FL | GA | HI | I [ADLN] | K [SY] | LA | M [ADEINOST] | N [CDEHJMVY] | O [ HKR] | PA | RI | S [CD] | T [NX] | UT | V [AT] | W [AIVY]）$“;
	} else if（includeTerritories && includeMilitary）{
		regex =“^（A [AEKLPRSZ] | C [AOT] | D [CE] | FL | G [AU] | HI | I [ADLN] | K [SY] | LA | M [ADEINOPST] | N [CDEHJMVY] | O [HKR] | P [AR] | RI | S [CD] | T [NX] | UT | V [AIT] | W [AIVY]）$“;
	} else if（includeTerritories）{
		regex =“^（A [KLRSZ] | C [AOT] | D [CE] | FL | G [AU] | HI | I [ADLN] | K [SY] | LA | M [ADEINOPST] | N [CDEHJMVY] | O [HKR] | P [AR] | RI | S [CD] | T [NX] | UT | V [AIT] | W [AIVY]）$“;
	} else {
		regex =“^（A [AEKLPRZ] | C [AOT] | D [CE] | FL | GA | HI | I [ADLN] | K [SY] | LA | M [ADEINOST] | N [CDEHJMVY] | O [ HKR] | PA | RI | S [CD] | T [NX] | UT | V [AT] | W [AIVY]）$“;
	}

	regex = caseSensitive？新的RegExp（正则表达式）：新的RegExp（正则表达式，“我”）;
	返回this.optional（元素）|| regex.test（value）;
}，“请指定有效状态”）;

// TODO检查值是否以<开头，否则不要尝试剥离任何东西
$ .validator.addMethod（“strippedminlength”，function（value，element，param）{
	return $（value）.text（）。length> = param;
}，$ .validator.format（“请输入至少{0}个字符”））;

$ .validator.addMethod（“time”，function（value，element）{
	返回this.optional（元素）|| / ^（[01] \ d | 2 [0-3] | [0-9]）（：[0-5] \ d）{1,2} $ / .test（value）;
}，“请输入00:00至23:59之间的有效时间”;

$ .validator.addMethod（“time12h”，function（value，element）{
	返回this.optional（元素）|| / ^（（0？[1-9] | 1 [012]）（：[0-5] \ d）{1,2}（\？[AP] M））$ / i.test（value）;
}，“请输入12小时上午/下午格式的有效时间”）;

//与url相同，但TLD是可选的
$ .validator.addMethod（“url2”，function（value，element）{
	返回this.optional（元素）|| /^(https?|ftp):\/\/(((([az]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF] ）|（％[\ DA-F] {2}）| [\ $＆'\（\）\ * \ +; =！] |：？）* @）（（（\ d | [1-9 ] \ d | 1 \ d \ d | 2 [0-4] \ d | 25 [0-5]）\（\ d |。[1-9] \ d | 1 \ d \ d | 2 [O- 4] \ d | 25 [0-5]）\（\ d |。[1-9] \ d | 1 \ d \ d | 2 [0-4] \ d | 25 [0-5]）\。 （\ d | [1-9] \ d | 1 \ d \ d | 2 [0-4] \ d | 25 [0-5]））|（（（[AZ] | \ d | [\ u00A0- \ uD7FF \ uF900- \ uFDCF \ uFDF0- \ uFFEF]）|（（[AZ] | \ d | [\ u00A0- \ uD7FF \ uF900- \ uFDCF \ uFDF0- \ uFFEF]）（[AZ] | \ d | -  | \ | _ |?| [\ u00A0- \ uD7FF \ uF900- \ uFDCF \ uFDF0- \ uFFEF]）*（[AZ] | \ d | [\ u00A0- \ uD7FF \ uF900- \ uFDCF \ uFDF0- \ uFFEF]）））\）*（（[AZ] |。[\ u00A0- \ uD7FF \ uF900- \ uFDCF \ uFDF0- \ uFFEF]）|（（[AZ] | [\ u00A0- \ uD7FF \ uF900- \ uFDCF \ uFDF0- \ uFFEF]）（[AZ] | \ d |  -  | \ | _ |?| [\ u00A0- \ uD7FF \ uF900- \ uFDCF \ uFDF0- \ uFFEF]）*（[AZ] | [\ u00A0- \ uD7FF \ uF900- \ uFDCF \ uFDF0- \ uFFEF]）））\）（：？\ d *））（\ /（（（[AZ] | \ d |  -  | \ | _ |?| [\ u00A0- \ uD7FF \ uF900- \ uFDCF \ uFDF0- \ uFFEF]）|（％[\ DA-F] {2}）| [！
}，$ .validator.messages.url）;

/ **
 *如果值是有效的车辆识别号（VIN），则返回true。
 *
 *适用于所有类型的文本输入。
 *
 * @example <input type =“text”size =“20”name =“VehicleID”class =“{required：true，vinUS：true}”/>
 * @desc声明必需的输入元素，其值必须是有效的车辆识别号。
 *
 * @name $ .validator.methods.vinUS
 * @type布尔值
 * @cat插件/验证/方法
 * /
$ .validator.addMethod（“vinUS”，function（v）{
	if（v.length！== 17）{
		返回虚假;
	}

	var LL = [“A”，“B”，“C”，“D”，“E”，“F”，“G”，“H”，“J”，“K”，“L”，“M “，”N“，”P“，”R“，”S“，”T“，”U“，”V“，”W“，”X“，”Y“，”Z“]，
		VL = [1,2,3,4,5,6,7,8,1,2,3,4,5,7,9,2,3,4,5,6,7,8,9]，
		FL = [8,7,6,5,4,3,2,10,0,9,8,7,6,5,4,3,2]，
		rs = 0，
		i，n，d，f，cd，cdv;

	for（i = 0; i <17; i ++）{
		f = FL [i];
		d = v.slice（i，i + 1）;
		if（i === 8）{
			cdv = d;
		}
		if（！isNaN（d））{
			d * = f;
		} else {
			for（n = 0; n <LL.length; n ++）{
				if（d.toUpperCase（）=== LL [n]）{
					d = VL [n];
					d * = f;
					if（isNaN（cdv）&& n === 8）{
						cdv = LL [n];
					}
					打破;
				}
			}
		}
		rs + = d;
	}
	cd = rs％11;
	if（cd === 10）{
		cd =“X”;
	}
	if（cd === cdv）{
		返回true;
	}
	返回虚假;
}，“指定的车辆识别号（VIN）无效。” ）;

$ .validator.addMethod（“zipcodeUS”，function（value，element）{
	返回this.optional（元素）|| / ^ \ d {5}（ -  \ d {4}）？$ / .test（value）;
}，“指定的美国邮政编码无效”）;

$ .validator.addMethod（“ziprange”，function（value，element）{
	返回this.optional（元素）|| / ^ 90 [2-5] \ d \ {2 \}  -  \ d {4} $ / .test（value）;
}，“您的邮政编码必须在902xx-xxxx到905xx-xxxx范围内”;
返回$;
}））;