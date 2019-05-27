/ *��
 * jQuery Validation Plugin v1.17.0
 *
 * https://jqueryvalidation.org/
 *
 *��Ȩ���У�c��2017 J��rn Zaefferer
 *����MIT���֤����
 * /
�����ܣ�������{
	if��typeof define ===��function��&& define.amd��{
		define��[��jquery������./ jquery.validate��]��factory��;
	} else if��typeof module ===��object��&& module.exports��{
		module.exports = factory��require����jquery������;
	} else {
		������jQuery��;
	}
}��function��$��{

��function����{

	function stripHtml��value��{

		//ɾ��html��ǩ�Ϳռ��ַ�
		return value.replace��/<��[^ <>] *��> / g��������.replace��/��nbsp; |����160; / gi��������

		//ɾ��������
		.replace��/ [������,;:!?%# $'����/ + = \ / \  - ������*��/��g����������;
	}

	$ .validator.addMethod����maxWords����function��value��element��params��{
		����this.optional��Ԫ�أ�|| stripHtml��value��.match��/ \ b \ w + \ b / g��.length <= params;
	}��$ .validator.format����������{0}�ֻ���١�������;

	$ .validator.addMethod����minWords����function��value��element��params��{
		����this.optional��Ԫ�أ�|| stripHtml��value��.match��/ \ b \ w + \ b / g��.length> = params;
	}��$ .validator.format��������������{0}�����ʡ�������;

	$ .validator.addMethod����rangeWords����function��value��element��params��{
		var valueStripped = stripHtml��value����
			������ʽ= / \ b \ w + \ b / g;
		����this.optional��Ԫ�أ�|| valueStripped.match��regex��.length> = params [0] && valueStripped.match��regex����length <= params [1];
	}��$ .validator.format����������{0}��{1}�����ʡ�������;

}������;

//���������mimetype�����ļ������е�ֵ
$ .validator.addMethod����accept����function��value��element��param��{

	//�ڶ����ϲ��mime���Է������ж������Ϳ��Խ���
	var typeParam = typeof param ===��string����param.replace��/ \ s / g������������image / *����
		optionalValue = this.optional��element����
		�ң�������������ʽ;

	//Ԫ���ǿ�ѡ��
	if��optionalValue��{
		return optionalValue;
	}

	if��$��element��.attr����type����===��file����{

		//��������ʽ��ʹ�õ�ת���ַ���
		//�μ���https��//stackoverflow.com/questions/3446170/escape-string-for-use-in-javascript-regex
		//����/ *��ת��Ϊ��/.*����Ϊͨ���
		typeParam = typeParam
				.replace��/[--\[\] \ /\\\\\\\\\\\\\\\\\\\\\\\\\|] / g����\\ $������
				.replace��/��/ g����|����
				.replace��/ \ / \ * / g����/��*����;

		//�ڼ��ÿ���ļ�֮ǰ���Ԫ���Ƿ����FileList
		if��element.files && element.files.length��{
			regex = new RegExp������������+ typeParam +����$������i����;
			for��i = 0; i <element.files.length; i ++��{
				file = element.files [i];

				//�Ӽ��ص��ļ��л�ȡmimetype����֤���Ƿ�ƥ��
				if����file.type.match��regex����{
					�������;
				}
			}
		}
	}

	//Ҫô����true����Ϊ�����Ѿ���֤��ÿ���ļ���Ҫô����Ϊ
	//�������֧��element.files��FileList����
	����true;
}��$ .validator.format����������һ����Ч��mimetypeֵ��������;

$ .validator.addMethod����alphanumeric����function��value��element��{
	����this.optional��Ԫ�أ�|| / ^ \ w + $ / i.test��value��;
}���������ż������ֺ��»��ߡ���;

/ *
 *���������ʺţ�����'giro'���룩��9λ����
 *��ͨ��'11���'��
 *���ǽ��ܴ��ո�ķ��ţ���Ϊ��ܳ�����
 *�ɽ��ܣ�123456789��12 34 56 789
 * /
$ .validator.addMethod����bankaccountNL����function��value��element��{
	if��this.optional��element����{
		����true;
	}
	if������/ ^ [0-9] {9} |��[0-9] {2}��{3} [0-9] {3} $ / .test��value������{
		�������;
	}

	//����'11���'
	var account = value.replace��/ / g����������//ɾ���ո�
		sum = 0��
		len = account.length��
		pos��factor��digit;
	for��pos = 0; pos <len; pos ++��{
		factor = len  -  pos;
		digit = account.substring��pos��pos + 1��;
		sum = sum + factor * digit;
	}
	�����ܺͣ�11 === 0;
}������ָ����Ч�������ʺš���;

$ .validator.addMethod����bankorgiroaccountNL����function��value��element��{
	����this.optional��Ԫ�أ�||
			��$ .validator.methods.bankaccountNL.call��this��value��element����||
			��$ .validator.methods.giroaccountNL.call��this��value��element����;
}������ָ����Ч�����л�ת���ʺš���;

/ **
 * BIC��ҵ���ʶ�����루ISO 9362������BIC��鲻����ʵ�Եı�֤��
 *
 * BICģʽ��BBBBCCLLbbb��8��11���ַ���; bbb�ǿ�ѡ�ģ�
 *
 *��֤�����ִ�Сд����ȷ���Լ���׼�����롣
 *
 * BIC��ϸ���壺
 *  - ǰ4���ַ� - ���д��루������ĸ��
 *  - ��������2���ַ� -  ISO 3166-1 alpha-2���Ҵ��루������ĸ��
 *  - ��������2���ַ� - λ�ô��루��ĸ�����֣�
 * һ����������'0'��'1'��ͷ
 * b���ڶ����ַ���������ĸ��������'O'�������֣�'0'��ʾ���ԣ���˲�������'1'��ʾ���������ߣ�'2'��ʾ����Ʒѣ�
 *  - ���3���ַ� - ��֧���룬��ѡ���������칫��Ϊ'XXX'�����򲻵���'X'��ͷ������ĸ�����֣�
 * /
$ .validator.addMethod����bic����function��value��element��{
    ����this.optional��Ԫ�أ�|| / ^��[AZ] {6} [A-Z2-9] [A-NP-Z1-9]����X {3} | [A-WY-Z0-9] [A-Z0-9] {2- }����$ / .test��value.toUpperCase������;
}������ָ����Ч��BIC���롱��;

/ *
 * C trade digo de identificació�ײ�����CIF��������������ʵ���˰��ʶ�����
 *��������������������http://es.wikipedia.org/wiki/C%C3%B3digo_de_identificaci%C3%B3n_fiscal�ҵ�
 *
 *��������CIF�ṹ��
 *
 * [T] [P] [P] [N] [N] [N] [N] [N] [C]
 *
 *�ص㣺
 *
 * T��1���ַ�����֯������[ABCDEFGHJKLMNPQRSUVW]
 * P��2���ַ���ʡ��
 * N��5���ַ���ʡ�ڵ�Secuencial���֡�
 * C��1���ַ�������λ��[0-9A-J]��
 *
 * [T]����֯���͡����ܵ�ֵ��
 *
 * A.��˾
 * B.�������ι�˾
 * C.һ�����ϵ
 * D.��˾���޺ϻ�
 * E.���������
 * F.������
 * G.Э��
 * H.����Ʋ��ƶ��еķ�������
 * J.������
 * K.�ɸ�ʽ
 * L.�ɸ�ʽ
 * M.�ɸ�ʽ
 * N.�Ǿ���ʵ��
 * P.�ط�����
 *�ʣ����λ����������ȣ��Լ����ں��ڽ̻���
 * R.���ں��ڽ̻�������2008���𶩹�EHA / 451/2008��
 *���������͵�����S.����
 * V.���ظ���
 * W.�������Ǿ���ĳ������
 *
 * [C]���������֡�����Tֵ�������������ֻ���ĸ��
 * [T]  - > [C]
 * ------ ----------
 * һ������
 * B����
 * E����
 * H����
 * K��
 * P��
 * Q��
 * S��
 *
 * /
$ .validator.addMethod����cifES����function��value��element��{
	���ϸ�ʹ�á�;

	if��this.optional��element����{
		����true;
	}

	var cifRegEx = new RegExp��/ ^��[ABCDEFGHJKLMNPQRSUVW]����\ d {7}����[0-9A-J]��$ / gi��;
	var letter = value.substring��0,1����// [T]
		number = value.substring��1,8����// [P] [P] [N] [N] [N] [N] [N]
		control = value.substring��8,9����// [C]
		all_sum = 0��
		even_sum = 0��
		odd_sum = 0��
		�ң�n��
		control_digit��
		control_letter;

	function isOdd��n��{
		����n��2 === 0;
	}

	//���ٸ�ʽ����
	if��value.length��== 9 ||��cifRegEx.test��value����{
		�������;
	}

	for��i = 0; i <number.length; i ++��{
		n = parseInt��number [i]��10��;

		//��ֵ�λ��
		if��isOdd��i����{

			//����λ�����ȳɱ����ӡ�
			n * = 2;

			//����˷�����10��������Ҫ����
			odd_sum + = n <10��n��n  -  9;

		//������ְλ
		//�ܽ�һ��
		} else {
			even_sum + = n;
		}
	}

	all_sum = even_sum + odd_sum;
	control_digit =��10  - ��all_sum��.toString������substr��-1������toString����;
	control_digit = parseInt��control_digit��10��> 9����0����control_digit;
	control_letter =��JABCDEFGHI��.substr��control_digit��1��.toString����;

	//���Ʊ�����һ������
	if��letter.match��/ [ABEH] /����{
		return control === control_digit;

	//���Ʊ�����һ����ĸ
	} else if��letter.match��/ [KPQS] /����{
		���ؿ���=== control_letter;
	}

	//Ҳ����
	���ؿ���=== control_digit || control === control_letter;

}������ָ����Ч��CIF��š��� ��;

/ *
 * Brazillian��������루Cadastrado de Pessoas Físicas���൱�ڰ���˰��ǼǺ��롣
 * CPF����ܹ���11λ���֣�9�����ֺ��2��������֤��У���롣
 * /
$ .validator.addMethod����cpfBR����function��value��{

	//��ֵ��ɾ�������ַ�
	value = value.replace��/��[?] @# $��^��*����_ + ='{} \ [\ \ \ \ \ \ \ | \ | \��;'<>����\ /��]��+ / g ��������;

	//���ֵֻ��11λ��
	if��value.length��== 11��{
		�������;
	}

	var sum = 0��
		firstCN��secondCN��checkResult��i;

	firstCN = parseInt��value.substring��9,10����10��;
	secondCN = parseInt��value.substring��10,11����10��;

	checkResult = function��sum��cn��{
		var result =��sum * 10����11;
		if����result === 10��||��result === 11����{
			result = 0;
		}
		return�����=== cn��;
	};

	//���ת������
	if��value ===����||
		ֵ===��00000000000��||
		ֵ===��11111111111��||
		ֵ===��22222222222��||
		ֵ===��33333333333��||
		ֵ===��44444444444��||
		ֵ===��55555555555��||
		ֵ===��66666666666��||
		ֵ===��77777777777��||
		ֵ===��88888888888��||
		ֵ===��99999999999��
	��{
		�������;
	}

	//��1�� - ʹ�õ�һ��֧Ʊ���룺
	for��i = 1; i <= 9; i ++��{
		sum = sum + parseInt��value.substring��i-1��i����10��*��11-i��;
	}

	//�����һ��֧Ʊ���루CN����Ч����ת������2  - ʹ�õڶ���֧Ʊ���룺
	if��checkResult��sum��firstCN����{
		sum = 0;
		for��i = 1; i <= 10; i ++��{
			sum = sum + parseInt��value.substring��i-1��i����10��*��12-i��;
		}
		return checkResult��sum��secondCN��;
	}
	�������;

}������ָ����Ч�Ĺ�������롱��;

// https://jqueryvalidation.org/creditcard-method/
//����https://en.wikipedia.org/wiki/Luhn_algorithm
$ .validator.addMethod����creditcard����function��value��element��{
	if��this.optional��element����{
		���ء������Բ�ƥ�䡱;
	}

	//ֻ���ܿո����ֺͶ̻���
	if��/ [^ 0-9 \  - ] + /.test��value����{
		�������;
	}

	var nCheck = 0��
		nDigit = 0��
		bEven = false��
		n��cDigit;

	value = value.replace��/ \ D / g��������;

	//������С����󳤶�
	// https://developer.ean.com/general_info/Valid_Credit_Card_Types
	if��value.length <13 || value.length> 19��{
		�������;
	}

	for��n = value.length  -  1; n> = 0; n--��{
		cDigit = value.charAt��n��;
		nDigit = parseInt��cDigit��10��;
		if��bEven��{
			if����nDigit * = 2��> 9��{
				nDigit  -  = 9;
			}
		}

		nCheck + = nDigit;
		bEven =��bEven;
	}

	return��nCheck��10��=== 0;
}�� ��������һ����Ч�����ÿ����롣�� ��;

/ *ע�⣺Castle.Components.Validator.CreditCardValidator���޸İ汾
 *��Apache���֤2.0�����·ַ�����ַΪhttp://www.apache.org/licenses/LICENSE-2.0
 *��Ч���ͣ����´￨��ǩ֤��������ͨ����dinersclub��;�У����֣�jcb��δ֪��ȫ�������������������ã�
 * /
$ .validator.addMethod����creditcardtypes����function��value��element��param��{
	if��/ [^ 0-9 \  - ] + /.test��value����{
		�������;
	}

	value = value.replace��/ \ D / g��������;

	var validTypes = 0x0000;

	if��param.mastercard��{
		validTypes | = 0x0001;
	}
	if��param.visa��{
		validTypes | = 0x0002;
	}
	if��param.amex��{
		validTypes | = 0x0004;
	}
	if��param.dinersclub��{
		validTypes | = 0x0008;
	}
	if��param.enroute��{
		validTypes | = 0x0010;
	}
	if��param.discover��{
		validTypes | = 0x0020;
	}
	if��param.jcb��{
		validTypes | = 0x0040;
	}
	if��param.unknown��{
		validTypes | = 0x0080;
	}
	if��param.all��{
		validTypes = 0x0001 | 0x0002 | 0x0004 | 0x0008 | 0x0010 | 0x0020 | 0x0040 | 0x0080;
	}
	if��validTypes��0x0001 && / ^��5 [12345]��/��test��value����{//���´￨
		return value.length === 16;
	}
	if��validTypes��0x0002 && / ^��4��/��test��value����{// Visa
		return value.length === 16;
	}
	if��validTypes��0x0004 && / ^��3 [47]��/��test��value����{// Amex
		return value.length === 15;
	}
	if��validTypes��0x0008 && / ^��3��0 [012345] | [68]����/��test��value����{// Dinersclub
		return value.length === 14;
	}
	if��validTypes��0x0010 && / ^��2��014 | 149����/��test��value����{// Enroute
		return value.length === 15;
	}
	if��validTypes��0x0020 && / ^��6011��/ .test��value����{//����
		return value.length === 16;
	}
	if��validTypes��0x0040 && / ^��3��/��test��value����{// Jcb
		return value.length === 16;
	}
	if��validTypes��0x0040 && / ^��2131 | 1800��/ .test��value����{// Jcb
		return value.length === 15;
	}
	if��validTypes��0x0080��{//δ֪
		����true;
	}
	�������;
}�� ��������һ����Ч�����ÿ����롣�� ��;

/ **
 *ͨ��@jameslouiz��֤�κθ������ŵĻ���
 *���ſ����ǿ�ѡ�Ļ����ġ�Ĭ���������Ҫ����
 *
 *�÷�ʾ����
 * currency��[��£����false]  - ʹ��false�����������֤
 *���ң�[��$����false]
 * currency��[��RM����false]  - Ҳ�����ڻ����ı��ķ��ţ����硰RM�� - ���������ּ��ص�
 *
 * <input class =��currencyInput��name =��currencyInput��>
 *
 *����ż��
 * currencyInput��{
 *���ң�[��$����false]
 *}
 *
 *�ϸ�ķ��ż�飨Ĭ�ϣ�
 * currencyInput��{
 *���ң���$��
 * //Ҫô
 *���ң�[��$����true]
 *}
 *
 *�������
 * currencyInput��{
 *���ң���$��£��¢��
 *}
 * /
$ .validator.addMethod����currency����function��value��element��param��{
    var isParamString = typeof param ===��string����
        symbol = isParamString��param��param [0]��
        soft = isParamString��true��param [1]��
        ������ʽ;

    symbol = symbol.replace��/��/ g��������;
    ����=����symbol +��]����symbol +��]����;
    regex =��^ [��+ symbol +����[1-9] {1} [0-9] {0,2}��\\��[0-9] {3}��*��\\��[0- 9] {0,2}��|��[1-9] {1} [0-9] {0��}��\\ [0-9] {0,2}��|����0��\\ [�� 0-9] {0,2}��|��\\ [0-9] {1,2}����$������;
    regex = new RegExp��������ʽ��;
    ����this.optional��Ԫ�أ�|| regex.test��value��;

}������ָ����Ч���ҡ���;

$ .validator.addMethod����dateFA����function��value��element��{
	����this.optional��Ԫ�أ�|| / ^ [1-4] \ d {3} \ /����0 [1-6] \ /����3 [0-1]��|����[1-2] [0-9]��|��0 ��[1-9]������|����1 [0-2] |��0 [7-9]����\ /��30 |����[1-2] [0-9]��|��0��le [1-9]��������$ / .test��value��;
}��$ .validator.messages.date��;

/ **
 *���ֵ����Ч���ڣ��򷵻�true��Ҳ������ʽ���dd / mm / yyyy��
 *
 * @example $ .validator.methods.date����01/01/1900����
 * @result�ǵ�
 *
 * @example $ .validator.methods.date����01/13/1990����
 * @result false
 *
 * @example $ .validator.methods.date����01.01.1900����
 * @result false
 *
 * @example <input name =��pippo��class =��{dateITA��true}��/>
 * @desc����һ����ѡ������Ԫ�أ���ֵ��������Ч���ڡ�
 *
 * @name $ .validator.methods.dateITA
 * @type����ֵ
 * @cat���/��֤/����
 * /
$ .validator.addMethod����dateITA����function��value��element��{
	var check = false��
		re = / ^ \ d {1,2} \ / \ d {1,2} \ / \ d {4} $ /��
		adata��gg��mm��aaaa��xdata;
	if��re.test��value����{
		adata = value.split����/����;
		gg = parseInt��adata [0]��10��;
		mm = parseInt��adata [1]��10��;
		aaaa = parseInt��adata [2]��10��;
		xdata = new Date��Date.UTC��aaaa��mm  -  1��gg��12,0,0,0����;
		if����xdata.getUTCFullYear����=== aaaa��&&��xdata.getUTCMonth����=== mm  -  1��&&��xdata.getUTCDate����=== gg����{
			check = true;
		} else {
			check = false;
		}
	} else {
		check = false;
	}
	����this.optional��Ԫ�أ�|| У��;
}��$ .validator.messages.date��;

$ .validator.addMethod����dateNL����function��value��element��{
	����this.optional��Ԫ�أ�|| / ^��0 [1-9] | [12] \ d | 3 [01]��[\ \ / \  - ]��0 [1-9] |��1 [012]����[\ \ / \ - ]��[12] \ d������\ d \ d��$ / .test��value��;
}��$ .validator.messages.date��;

//�Ͼɵġ����ܡ��ļ���չ�����������ĵ���http��//docs.jquery.com/Plugins/Validation/Methods/accept
$ .validator.addMethod����extension����function��value��element��param��{
	param = typeof param ===��string����param.replace��/��/ g����|��������png | jpe��g | gif��;
	����this.optional��Ԫ�أ�|| value.match��new RegExp����\\������+ param +����$������i������;
}��$ .validator.format����������һ����Ч��չ����ֵ��������;

/ **
 *����ת���ʺţ������к��룩���7λ��
 * /
$ .validator.addMethod����giroaccountNL����function��value��element��{
	����this.optional��Ԫ�أ�|| / ^ [0-9] {1,7} $ / .test��value��;
}������ָ����Ч��ת���ʺš���;

/ **
 * IBAN�ǹ��������ʺš�
 *�������ض�����/�����ĸ�ʽ��Ҳ�ڴ˴����м��
 *
 *��֤�����ִ�Сд����ȷ���Լ���׼�����롣
 * /
$ .validator.addMethod����iban����function��value��element��{

	//һЩ���ټ򵥵Ĳ��ԣ��Է�ֹ����Ҫ�Ĺ���
	if��this.optional��element����{
		����true;
	}

	//ɾ���ո�ʹ�д
	var iban = value.replace��/ / g����������toUpperCase������
		ibancheckdigits =������
		leadingZeroes = true��
		cRest =������
		cOperator =������
		countrycode��ibancheck��charAt��cChar��bbanpattern��bbancountrypatterns��ibanregexp��i��p;

	//���IBAN���볤�ȡ�
	// ��������
	//���Ҵ���ISO 3166-1  - ������ĸ��
	//����У��λ��
	//���������ʺţ�BBAN�� - ���30���ַ�
	var minimalIBANlength = 5;
	if��iban.length <minimalIBANlength��{
		�������;
	}

	//������/�������벢�����ض�����/�����ĸ�ʽ
	countrycode = iban.substring��0,2��;
	bbancountrypatterns = {
		��AL������\\ d {8} [\\ dA-Z] {16}����
		��AD������\\ d {8} [\\ dA-Z] {12}����
		��AT������\\ d {16}����
		��AZ������[\\ dA-Z] {4} \\ d {20}����
		��BE������\\ d {12}����
		��BH������[AZ] {4} [\\ dA-Z] {14}����
		��BA������\\ d {16}����
		��BR������\\ d {23} [AZ] [\\ dA-Z]����
		��BG������[AZ] {4} \\ d {6} [\\ dA-Z] {8}����
		��CR������\\ d {17}����
		��HR������\\ d {17}����
		��CY������\\ d {8} [\\ dA-Z] {16}����
		��CZ������\\ d {20}����
		��DK������\\ d {14}����
		��DO������[AZ] {4} \\ d {20}����
		��EE������\\ d {16}����
		��FO������\\ d {14}����
		��FI������\\ d {14}����
		��FR������\\ d {10} [\\ dA-Z] {11} \\ d {2}����
		��GE������[\\ dA-Z] {2} \\ d {16}����
		��DE������\\ d {18}����
		��GI������[AZ] {4} [\\ dA-Z] {15}����
		��GR������\\ d {7} [\\ dA-Z] {16}����
		��GL������\\ d {14}����
		��GT������[\\ dA-Z] {4} [\\ dA-Z] {20}����
		��HU������\\ d {24}����
		���ǡ�����\\ d {22}����
		��IE������[\\ dA-Z] {4} \\ d {14}����
		��IL������\\ d {19}����
		��IT������[AZ] \\ d {10} [\\ dA-Z] {12}����
		��KZ������\\ d {3} [\\ dA-Z] {13}����
		��KW������[AZ] {4} [\\ dA-Z] {22}����
		��LV������[AZ] {4} [\\ dA-Z] {13}����
		��LB������\\ d {4} [\\ dA-Z] {20}����
		��LI������\\ d {5} [\\ dA-Z] {12}����
		��LT������\\ d {16}����
		��LU������\\ d {3} [\\ dA-Z] {13}����
		��MK������\\ d {3} [\\ dA-Z] {10} \\ d {2}����
		��MT������[AZ] {4} \\ d {5} [\\ dA-Z] {18}����
		��MR������\\ d {23}����
		��MU������[AZ] {4} \\ d {19} [AZ] {3}����
		��MC������\\ d {10} [\\ dA-Z] {11} \\ d {2}����
		��MD������[\\ dA-Z] {2} \\ d {18}����
		���ҡ�����\\ d {18}����
		��NL������[AZ] {4} \\ d {10}����
		����������\\ d {11}����
		��PK������[\\ dA-Z] {4} \\ d {16}����
		��PS������[\\ dA-Z] {4} \\ d {21}����
		��PL������\\ d {24}����
		��PT������\\ d {21}����
		��RO������[AZ] {4} [\\ dA-Z] {16}����
		��SM������[AZ] \\ d {10} [\\ dA-Z] {12}����
		��SA������\\ d {2} [\\ dA-Z] {18}����
		��RS������\\ d {18}����
		��SK������\\ d {20}����
		��SI������\\ d {15}����
		��ES������\\ d {20}����
		��SE������\\ d {20}����
		��CH������\\ d {5} [\\ dA-Z] {12}����
		��TN������\\ d {20}����
		��TR������\\ d {5} [\\ dA-Z] {17}����
		��AE������\\ d {3} \\ d {16}����
		��GB������[AZ] {4} \\ d {14}����
		��VG������[\\ dA-Z] {4} \\ d {16}��
	};

	bbanpattern = bbancountrypatterns [countrycode];

	//��Ϊ�µĹ��ҽ���ʼʹ��IBAN
	// future������ֻ�����Ҵ����Ƿ���֪��
	//����Է�ֹ�󱨣�����������
	//�ɴ�������󱨽�������
	//������ζ���ͨ�������У�����֤��
	//����δ֪���ϸ���Ӧ�÷���FALSE
	//����
	if��typeof bbanpattern��==��undefined����{
		ibanregexp = new RegExp����^ [AZ] {2} \\ d {2}��+ bbanpattern +��$����������;
		if������ibanregexp.test��iban������{
			�������; //����/�����ض���ʽ��Ч
		}
	}

	//���ڼ��У��ͣ�����ת��Ϊ����
	ibancheck = iban.substring��4��iban.length��+ iban.substring��0,4��;
	for��i = 0; i <ibancheck.length; i ++��{
		charAt = ibancheck.charAt��i��;
		if��charAt��==��0����{
			leadingZeroes = false;
		}
		if����leadingZeroes��{
			ibancheckdigits + =��0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ��.indexOf��charAt��;
		}
	}

	//��������ibancheckdigits��97
	for��p = 0; p <ibancheckdigits.length; p ++��{
		cChar = ibancheckdigits.charAt��p��;
		cOperator =����+ cRest +����+ cChar;
		cRest = cOperator��97;
	}
	return cRest === 1;
}������ָ����Ч��IBAN����;

$ .validator.addMethod����integer����function��value��element��{
	����this.optional��Ԫ�أ�|| / ^  - ��\ d + $ / .test��value��;
}�������������������ʮ����������;

$ .validator.addMethod����ipv4����function��value��element��{
	����this.optional��Ԫ�أ�|| /^(25[0-5]|2[0-4]\d|[01]?\d\d?)\.(25[0-5]|2[0-4]\d|[01 ] \ d \ d��\��25 [0-5] |��2 [0-4] \ d | [01] \ d \ d��\��25 [0-5] |��2 [0 -4] \ d | [01]��\ d \ d����$ / i.test��value��;
}������������Ч��IP v4��ַ���� ��;

$ .validator.addMethod����ipv6����function��value��element��{
	����this.optional��Ԫ�أ�|| / ^������[0-9A-��F] {1,4}����{7} [0-9A-��F] {1,4}��|����[0-9A-��-F ] {1,4}����{6}��[0-9A-��F] {1,4}��|����[0-9A-��F] {1,4}����{5}�� ��[0-9A-��F] {1,4}������[0-9A-��F] {1,4}��|����[0-9A-��F] {1,4} ����{4}����[0-9A-��F] {1,4}����{0,2} [0-9A-��F] {1,4}��|����[0-9A -Fa-F] {1,4}����{3}����[0-9A-��F] {1,4}����{0,3} [0-9A-��F] {1�� 4}��|����[0-9A-��F] {1,4}����{2}����[0-9A-��F] {1,4}����{0,4} [0 -9A��-F] {1,4}��|����[0-9A-��F] {1,4}����{6}����\ b����25 [0-5]��|�� 1 \ d {2}��|��2 [0-4] \ d��|����\ d {1,2}����\ b����\��{3}��\ b����25 [0-5]�� |��1 \ d {2}��|��2 [0-4] \ d��|��\ d {1,2}����\ b����|����[0-9A-��F] {1�� 4}����{0,5}������\ b����25 [0-5]��|��1 \ d {2}��|��2 [0-4] \ d��|��\ d {1�� 2}����\ b����\��{3}��\ b����25 [0-5]��|��1 \ d {2}��|��2 [0-4] \ d��|��\ d { 1,2}����\ b����|��::��[0-9A-��F] {1,4}����{0,5}����\ b����25 [0-5]��| ��1 \ d {2}��|��2 [0-4] \ d��|����\ d {1,2}����\ b����\��{3}��\ b����25 [0-5] ��|��1 \ d {2}��|��2 [0-4] \ d��|��\ d {1,2}����\ b����|��[0-9A-��F] {1�� 4} ::��[0-9A-��F] {1,4}����{0,5} [0-9A-��F] {1,4}��|��::��[0-9A -Fa-F] {1,4}����{0��
}������������Ч��IP v6��ַ���� ��;

$ .validator.addMethod����lettersonly����function��value��element��{
	����this.optional��Ԫ�أ�|| / ^ [az] + $ / i.test��value��;
}���������š���;

$ .validator.addMethod����letterswithbasicpunc����function��value��element��{
	����this.optional��Ԫ�أ�|| / ^ [az \  - ��������'��\ s] + $ / i.test��value��;
}�������ż�������š���;

$ .validator.addMethod����mobileNL����function��value��element��{
	����this.optional��Ԫ�أ�|| / ^����\ + | 00��\ S |��������\ S \  -  \ S����31��\ S |��������\ S \  -  \ S����\��0 \��\  -  \ s]�ģ�����| 0��6����\ s | \ s��\  -  \ s������[0-9]��{8} $ / .test��value��;
}������ָ����Ч���ֻ����롱��;

/ *����UK�ֻ����ܣ���ִ�����·������˴���
 *��ԭʼ�������RegExģʽ���бȽϣ�
 * ^ \��������:(����00 \����[\ s \  - ]��\����| \ +����44��\����[\ s \  - ]��\����������0 \ ��[\ S \  - ] \����|����������0����[1-9] \ d {1,4} \��\ S \ d \  - ] +��$
 *���$ 1Ϊ'44'������ȡ$ 1����$ǰ׺����Ϊ'+44 <space>'������$ prefix����Ϊ'0'
 *��ȡ$ 2��ɾ�����ַ����ո�����š��绰����ϲ�$ǰ׺��$ 2��
 *��������������ַ�ҵ����ǳ���ϸ��GB�绰����RegExģʽ��
 * http://www.aa-asterisk.org.uk/index.php/Regular_Expressions_for_Validating_and_Formatting_GB_Telephone_Numbers
 * /
$ .validator.addMethod����mobileUK����function��phone_number��element��{
	phone_number = phone_number.replace��/ \��| \��| \ s + |  -  / g��������;
	����this.optional��Ԫ�أ�|| phone_number.length> 9 &&
		phone_number.match��/ ^����:(��:( ?: 00 \ s��| \ +��44 \ s��| 0��7������[1345789] \ d {2} | 624��\ s��\ d {3} \ s��\ d {3}��$ /��;
}������ָ����Ч���ֻ����롱��;

$ .validator.addMethod����netmask����function��value��element��{
    ����this.optional��Ԫ�أ�|| /^(254|252|248|240|224|192|128)\.0\.0\.0|255\.(254|252|248|240|224|192|128|0)\.0 \ 0.0 |��255 \ 0.255 \��254 | 252 | 248 | 240 | 224 | 192 | 128 | 0��\ 0 |����255 \ 0.255 \ 0.255 \��254 | 252 | 248 | 240 | 224 | 192 | 128 | 0��/i.test��value��;
}������������Ч���������롣�� ��;

/ *
 * NIE��N Coal mero de Identificaci Trade n de Extranjero������������ָ����������˰��
 *�κ�����˵�Ȩ����
 *
 * NIE�൱����������N Coal mero de Identificaci Trade n Fiscal��NIF������Ϊ����
 *ʶ����롣CIF��ţ�Certificado de Identificació�ײ�������ͬ��NIF����������
 *��˾�����Ǹ��ˡ�NIE��'X'��'Y'���7��8λ������ɣ�Ȼ������һ����ĸ��
 * /
$ .validator.addMethod����nieES����function��value��element��{
	���ϸ�ʹ�á�;

	if��this.optional��element����{
		����true;
	}

	var nieRegEx = new RegExp��/ ^ [MXYZ] {1} [0-9] {7,8} [TRWAGMYFPDXBNJZSQVHLCKET] {1} $ / gi��;
	var validChars =��TRWAGMYFPDXBNJZSQVHLCKET����
		letter = value.substr��value.length  -  1��.toUpperCase������
		��;

	value = value.toString������toUpperCase����;

	//���ٸ�ʽ����
	if��value.length> 10 || value.length <9 ||��nieRegEx.test��value����{
		�������;
	}

	// X��ʾ��ͬ������
	// Y��ʾ����+ 10000000
	// Z��ʾ����+ 20000000
	value = value.replace��/ ^ [X] /����0����
		.replace��/ ^ [Y] /����1����
		.replace��/ ^ [Z] /����2����;

	number = value.length === 9��value.substr��0,8����value.substr��0,9��;

	return validChars.charAt��parseInt��number��10����23��=== letter;

}������ָ����Ч��NIE���롣�� ��;

/ *
 * N Coal mero de Identificaci Trade n Fiscal��NIF��������������ʹ�õ�˰��ʶ��ʽ
 * /
$ .validator.addMethod����nifES����function��value��element��{
	���ϸ�ʹ�á�;

	if��this.optional��element����{
		����true;
	}

	value = value.toUpperCase����;

	//������ʽ����
	if����value.match��������^ [AZ] {1} [0-9] {7} [A-Z0-9] {1} $ | ^ [T] {1} [A-Z0-9 ] {8} $��| ^ [0-9] {8} [AZ] {1} $��������{
		�������;
	}

	//����NIF
	if��/ ^ [0-9] {8} [AZ] {1} $ /.test��value����{
		return����TRWAGMYFPDXBNJZSQVHLCKE��.charAt��value.substring��8,0����23��=== value.charAt��8����;
	}

	//�����ؼ�NIF����K��L��M��ͷ��
	if��/ ^ [KLM] {1} /.test��value����{
		return��value [8] ===��TRWAGMYFPDXBNJZSQVHLCKE��.charAt��value.substring��8,1����23����;
	}

	�������;

}������ָ����Ч��NIF���롣�� ��;

/ *
 * Numer identyfikacji podatkowej��NIP���ǲ�����˾ʹ�õ�˰��ʶ��ʽ
 * /
$ .validator.addMethod����nipPL����function��value��{
	���ϸ�ʹ�á�;

	value = value.replace��/ [^ 0-9] / g��������;

	if��value.length��== 10��{
		�������;
	}

	var arrSteps = [6,5,7,2,3,4,5,6,7];
	var intSum = 0;
	for��var i = 0; i <9; i ++��{
		intSum + = arrSteps [i] * value [i];
	}
	var int2 = intSum��11;
	var intControlNr =��int2 === 10����0��int2;

	return��intControlNr === parseInt��value [9]��10����;
}������ָ����Ч��NIP���롣�� ��;

$ .validator.addMethod����notEqualTo����function��value��element��param��{
	����this.optional��Ԫ�أ�|| ��$��validator.methods.equalTo.call��this��value��element��param��;
}���������벻ͬ��ֵ��ֵ������ͬ���� ��;

$ .validator.addMethod����nowhitespace����function��value��element��{
	����this.optional��Ԫ�أ�|| / ^ \ S + $ / i.test��value��;
}�����벻Ҫ�ո񡱣�;

/ **
*����ֶ�ֵ�������ʽRegExpƥ�䣬�򷵻�true
*
* @example $ .validator.methods.pattern����AR1004����element��/ ^ AR \ d {4} $ /��
* @result�ǵ�
*
* @example $ .validator.methods.pattern����BR1004����element��/ ^ AR \ d {4} $ /��
* @result false
*
* @name $ .validator.methods.pattern
* @type����ֵ
* @cat���/��֤/����
* /
$ .validator.addMethod����pattern����function��value��element��param��{
	if��this.optional��element����{
		����true;
	}
	if��typeof param ===��string����{
		param = new RegExp����^��������+ param +����$����;
	}
	return param.test��value��;
}�� ����Ч�ĸ�ʽ���� ��;

/ **
 *������绰������10λ������11λ����+31��ͷ����
 * /
$ .validator.addMethod����phoneNL����function��value��element��{
	����this.optional��Ԫ�أ�|| / ^����\ + | 00��\ S |��������\ S \  -  \ S����31��\ S |��������\ S \  -  \ S����\��0 \��\  -  \ s]�ģ�����| 0��[1-9]����\ s | \ s��\  -  \ s������[0-9]��{8} $ / .test��value��;
}������ָ����Ч�ĵ绰���롣�� ��;

/ *����UK�ֻ����ܣ���ִ�����·������˴���
 *��ԭʼ�������RegExģʽ���бȽϣ�
 * ^ \��������:(����00 \����[\ s \  - ]��\����| \ +����44��\����[\ s \  - ]��\����������0 \ ��[\ S \  - ] \����|����������0����[1-9] \ d {1,4} \��\ S \ d \  - ] +��$
 *���$ 1Ϊ'44'������ȡ$ 1����$ǰ׺����Ϊ'+44 <space>'������$ prefix����Ϊ'0'
 *��ȡ$ 2��ɾ�����ַ����ո�����š��绰����ϲ�$ǰ׺��$ 2��
 *��������������ַ�ҵ����ǳ���ϸ��GB�绰����RegExģʽ��
 * http://www.aa-asterisk.org.uk/index.php/Regular_Expressions_for_Validating_and_Formatting_GB_Telephone_Numbers
 * /

//ƥ��Ӣ���̶��绰+�ƶ��绰��������01-3���ڹ̶��绰��07�����ƶ��绰���ų����߼��绰����
$ .validator.addMethod����phonesUK����function��phone_number��element��{
	phone_number = phone_number.replace��/ \��| \��| \ s + |  -  / g��������;
	����this.optional��Ԫ�أ�|| phone_number.length> 9 &&
		phone_number.match��/ ^����:(��:( ?: 00 \ s��| \ +��44 \ s��| 0��������1 \ d {8,9} | [23] \ d {9} | 7������[1345789] \ d {8} | 624 \ d {6}������$ /��;
}������ָ����Ч��Ӣ���绰���롱��;

/ *����UK�ֻ����ܣ���ִ�����·������˴���
 *��ԭʼ�������RegExģʽ���бȽϣ�
 * ^ \��������:(����00 \����[\ s \  - ]��\����| \ +����44��\����[\ s \  - ]��\����������0 \ ��[\ S \  - ] \����|����������0����[1-9] \ d {1,4} \��\ S \ d \  - ] +��$
 *���$ 1Ϊ'44'������ȡ$ 1����$ǰ׺����Ϊ'+44 <space>'������$ prefix����Ϊ'0'
 *��ȡ$ 2��ɾ�����ַ����ո�����š��绰����ϲ�$ǰ׺��$ 2��
 *��������������ַ�ҵ����ǳ���ϸ��GB�绰����RegExģʽ��
 * http://www.aa-asterisk.org.uk/index.php/Regular_Expressions_for_Validating_and_Formatting_GB_Telephone_Numbers
 * /
$ .validator.addMethod����phoneUK����function��phone_number��element��{
	phone_number = phone_number.replace��/ \��| \��| \ s + |  -  / g��������;
	����this.optional��Ԫ�أ�|| phone_number.length> 9 &&
		phone_number.match��/ ^����:(��:( ?: 00 \ s��| \ +��44 \ s����|������\����0����������\ d {2} \����\ ����\ d {4} \ S \ d {4} |��\ d {3} \��\ S \ d {3} \ S \ d {3,4} |��������\ d {4} \�� ��\ s��������\ d {5} | \ d {3} \ s��\ d {3}��| \ d {5} \����\ s��\ d {4,5}��$ /�� ;
}������ָ����Ч�ĵ绰���롱��;

/ **
 *ƥ�������绰�����ʽ
 *
 *������벻����1��ͷ��ǰ׺������1��ͷ
 *����' - '��''��Ϊ�ָ��������������������Χ��parens
 *��Щ�˿����������ǵĺ���ǰ��һ��'1'
 *
 * 1��212��-999-2345��
 * 212 999 2344��
 * 212-999-0983
 *
 * ������
 * 111-123-5434
 * ������
 * 212 123 4567
 * /
$ .validator.addMethod����phoneUS����function��phone_number��element��{
	phone_number = phone_number.replace��/ \ s + / g��������;
	����this.optional��Ԫ�أ�|| phone_number.length> 9 &&
		phone_number.match��/ ^��\ +��1  - ��������\��[2-9]��[02-9] \ d | 1 [02-9]��\��| [2-9]��[02 -9] \ d | 1 [02-9]���� - ��[2-9]��[02-9] \ d | 1 [02-9]�� - ��\ d {4} $ /��;
}������ָ����Ч�ĵ绰���롱��;

/ *
* Valida CEPs��brasileiros��
*
* Formatos aceitos��
* 99999-999
* 99.999-999
* 99999999
* /
$ .validator.addMethod����postalcodeBR����function��cep_value��element��{
	����this.optional��Ԫ�أ�|| / ^ \ d {2}��\ d {3}  -  \ d {3}��$ | ^ \ d {5}  - ��\ d {3}��$ /��test��cep_value��;
}����Informe um CEP válido���� ��;

/ **
 *ƥ����Ч�ļ��ô���������
 *
 * @example jQuery.validator.methods.postalCodeCA����H0H 0H0����element��
 * @result�ǵ�
 *
 * @example jQuery.validator.methods.postalCodeCA����H0H0H0����element��
 * @result false
 *
 * @name jQuery.validator.methods.postalCodeCA
 * @type����ֵ
 * @cat���/��֤/����
 * /
$ .validator.addMethod����postalCodeCA����function��value��element��{
	����this.optional��Ԫ�أ�|| / ^ [ABCEGHJKLMNPRSTVXY] \ d [ABCEGHJKLMNPRSTVWXYZ] * \ d [ABCEGHJKLMNPRSTVWXYZ] \ d $ / i.test��value��;
}������ָ����Ч���������롱��;

/ *ƥ��������������루CAP��* /
$ .validator.addMethod����postalcodeIT����function��value��element��{
	����this.optional��Ԫ�أ�|| / ^ \ d {5} $ / .test��value��;
}������ָ����Ч���������롱��;

$ .validator.addMethod����postalcodeNL����function��value��element��{
	����this.optional��Ԫ�أ�|| / ^ [1-9] [0-9] {3} \ s��[a-zA-Z] {2} $ / .test��value��;
}������ָ����Ч���������롱��;

//ƥ��Ӣ���������롣��ӵ���Լ������������Ӣ����ϿȺ����ƥ�䣨�Ǳ�׼Ӣ����
$ .validator.addMethod����postcodeUK����function��value��element��{
	����this.optional��Ԫ�أ�|| / ^������[A-PR-UWYZ] [0-9]��|��[A-PR-UWYZ] [0-9] [0-9]��|��[A-PR-UWYZ] [A- HK-Y] [0-9]��|��[A-PR-UWYZ] [A-HK-Y] [0-9] [0-9]��|��[A-PR-UWYZ] [0-9 ] [A-HJKSTUW]��|����[A-PR-UWYZ] [A-HK-Y] [0-9] [ABEHMNPRVWXY]����\ S��[0-9] [ABD-HJLNP-UW-Z ] {2}��|��GIR��\ s����0AA����$ / i.test��value��;
}������ָ����Ч��Ӣ���������롱��;

/ *
 *����˵�����ٱ��������ѡ����Yƥ���X���롣��
 *
 *���ս������Щ���붼���ǣ�
 *
 * <input class =��productinfo��name =��partnumber��>
 * <input class =��productinfo��name =��description��>
 *
 * ...����֤������������д����һ����
 *
 * partnumber��{require_from_group��[1������productinfo��]}��
 *˵����{require_from_group��[1������productinfo��]}
 *
 * options [0]��������������д���ֶ���
 * options [1]��CSSѡ���������ڶ������������ֶ���
 * /
$ .validator.addMethod����require_from_group����function��value��element��options��{
	var $ fields = $��options [1]��element.form����
		$ fieldsFirst = $ fields.eq��0����
		validator = $ fieldsFirst.data����valid_req_grp������$ fieldsFirst.data����valid_req_grp������$ .extend��{}��this����
		isValid = $ fields.filter��function����{
			return validator.elementValue��this��;
		}����length> = options [0];

	//�洢��¡����֤���Թ�������֤
	$ fieldsFirst.data����valid_req_grp����validator��;

	//���δ��֤Ԫ�أ�������ÿ��require_from_group�ֶε���֤����
	if����$��element��.data����being_validated������{
		$ fields.data����being_validated����true��;
		$ fields.each��function����{
			validator.element��this��;
		}��;
		$ fields.data����being_validated����false��;
	}
	return isValid;
}��$ .validator.format��������д��Щ�ֶ�������{0}����������;

/ *
 *����˵��Ҫô������д������ѡ����Yƥ���X���룬
 *���߱���ȫ�����������գ�����
 *
 *���ս���ǣ���Щ���붼���ǣ�
 *
 * <input class =��productinfo��name =��partnumber��>
 * <input class =��productinfo��name =��description��>
 * <input class =��productinfo��name =��color��>
 *
 * ...����֤������������������������䣬
 *���߶����ǡ�
 *
 * partnumber��{skip_or_fill_minimum��[2������productinfo��]}��
 *˵����{skip_or_fill_minimum��[2������productinfo��]}��
 * color��{skip_or_fill_minimum��[2������productinfo��]}
 *
 * options [0]��������������д���ֶ���
 * options [1]��CSSѡ���������ڶ������������ֶ���
 *
 * /
$ .validator.addMethod����skip_or_fill_minimum����function��value��element��options��{
	var $ fields = $��options [1]��element.form����
		$ fieldsFirst = $ fields.eq��0����
		validator = $ fieldsFirst.data����valid_skip������$ fieldsFirst.data����valid_skip������$ .extend��{}��this����
		numberFilled = $ fields.filter��function����{
			return validator.elementValue��this��;
		} �������ȣ�
		isValid = numberFilled === 0 || numberFilled> = options [0];

	//�洢��¡����֤���Թ�������֤
	$ fieldsFirst.data����valid_skip����validator��;

	//���δ��֤Ԫ�أ�������ÿ��skip_or_fill_minimum�ֶε���֤����
	if����$��element��.data����being_validated������{
		$ fields.data����being_validated����true��;
		$ fields.each��function����{
			validator.element��this��;
		}��;
		$ fields.data����being_validated����false��;
	}
	return isValid;
}��$ .validator.format������������Щ�ֶλ���д����{0}����������;

/ *ͨ��@jdforsythe��֤������/�����
 *���Բ����ִ�Сд����Ҫ��д - Ĭ�ϲ����ִ�Сд
 *���԰����������� - Ĭ�ϲ�����
 *���԰�����������������д��AA��AE��AP�� - Ĭ�ϲ�����
 *
 *ע�⣺�����ҡ����ǰ���DC�����ױ���������
 *
 *�÷�ʾ����
 *
 *����Ĭ������ - �����ִ�Сд��û������û�о���
 * stateInput��{
 * caseSensitive��false��
 * includeTerritories��false��
 * includeMilitary��false
 *}
 *
 *ֻ�����д��ĸ��û��������û�о�����
 * stateInput��{
 * caseSensitive��false
 *}
 *
 *�����ִ�Сд��������������������������
 * stateInput��{
 * includeTerritories��true
 *}
 *
 *�������д��ĸ�����������;�����
 * stateInput��{
 * caseSensitive��true��
 * includeTerritories��true��
 * includeMilitary���ǵ�
 *}
 *
 * /
$ .validator.addMethod����stateUS����function��value��element��options��{
	var isDefault = typeof options ===��undefined����
		caseSensitive =��isDefault || typeof options.caseSensitive ===��undefined������false��options.caseSensitive��
		includeTerritories =��isDefault || typeof options.includeTerritories ===��undefined������false��options.includeTerritories��
		includeMilitary =��isDefault || typeof options.includeMilitary ===��undefined������false��options.includeMilitary��
		������ʽ;

	if����includeTerritories &&��includeMilitary��{
		regex =��^��A [KLRZ] | C [AOT] | D [CE] | FL | GA | HI | I [ADLN] | K [SY] | LA | M [ADEINOST] | N [CDEHJMVY] | O [ HKR] | PA | RI | S [CD] | T [NX] | UT | V [AT] | W [AIVY]��$��;
	} else if��includeTerritories && includeMilitary��{
		regex =��^��A [AEKLPRSZ] | C [AOT] | D [CE] | FL | G [AU] | HI | I [ADLN] | K [SY] | LA | M [ADEINOPST] | N [CDEHJMVY] | O [HKR] | P [AR] | RI | S [CD] | T [NX] | UT | V [AIT] | W [AIVY]��$��;
	} else if��includeTerritories��{
		regex =��^��A [KLRSZ] | C [AOT] | D [CE] | FL | G [AU] | HI | I [ADLN] | K [SY] | LA | M [ADEINOPST] | N [CDEHJMVY] | O [HKR] | P [AR] | RI | S [CD] | T [NX] | UT | V [AIT] | W [AIVY]��$��;
	} else {
		regex =��^��A [AEKLPRZ] | C [AOT] | D [CE] | FL | GA | HI | I [ADLN] | K [SY] | LA | M [ADEINOST] | N [CDEHJMVY] | O [ HKR] | PA | RI | S [CD] | T [NX] | UT | V [AT] | W [AIVY]��$��;
	}

	regex = caseSensitive���µ�RegExp��������ʽ�����µ�RegExp��������ʽ�����ҡ���;
	����this.optional��Ԫ�أ�|| regex.test��value��;
}������ָ����Ч״̬����;

// TODO���ֵ�Ƿ���<��ͷ������Ҫ���԰����κζ���
$ .validator.addMethod����strippedminlength����function��value��element��param��{
	return $��value��.text������length> = param;
}��$ .validator.format��������������{0}���ַ�������;

$ .validator.addMethod����time����function��value��element��{
	����this.optional��Ԫ�أ�|| / ^��[01] \ d | 2 [0-3] | [0-9]������[0-5] \ d��{1,2} $ / .test��value��;
}����������00:00��23:59֮�����Чʱ�䡱;

$ .validator.addMethod����time12h����function��value��element��{
	����this.optional��Ԫ�أ�|| / ^����0��[1-9] | 1 [012]������[0-5] \ d��{1,2}��\��[AP] M����$ / i.test��value��;
}����������12Сʱ����/�����ʽ����Чʱ�䡱��;

//��url��ͬ����TLD�ǿ�ѡ��
$ .validator.addMethod����url2����function��value��element��{
	����this.optional��Ԫ�أ�|| /^(https?|ftp):\/\/(((([az]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF] ��|����[\ DA-F] {2}��| [\ $��'\��\��\ * \ +; =��] |������* @��������\ d | [1-9 ] \ d | 1 \ d \ d | 2 [0-4] \ d | 25 [0-5]��\��\ d |��[1-9] \ d | 1 \ d \ d | 2 [O- 4] \ d | 25 [0-5]��\��\ d |��[1-9] \ d | 1 \ d \ d | 2 [0-4] \ d | 25 [0-5]��\�� ��\ d | [1-9] \ d | 1 \ d \ d | 2 [0-4] \ d | 25 [0-5]����|������[AZ] | \ d | [\ u00A0- \ uD7FF \ uF900- \ uFDCF \ uFDF0- \ uFFEF]��|����[AZ] | \ d | [\ u00A0- \ uD7FF \ uF900- \ uFDCF \ uFDF0- \ uFFEF]����[AZ] | \ d | -  | \ | _ |?| [\ u00A0- \ uD7FF \ uF900- \ uFDCF \ uFDF0- \ uFFEF]��*��[AZ] | \ d | [\ u00A0- \ uD7FF \ uF900- \ uFDCF \ uFDF0- \ uFFEF]������\��*����[AZ] |��[\ u00A0- \ uD7FF \ uF900- \ uFDCF \ uFDF0- \ uFFEF]��|����[AZ] | [\ u00A0- \ uD7FF \ uF900- \ uFDCF \ uFDF0- \ uFFEF]����[AZ] | \ d |  -  | \ | _ |?| [\ u00A0- \ uD7FF \ uF900- \ uFDCF \ uFDF0- \ uFFEF]��*��[AZ] | [\ u00A0- \ uD7FF \ uF900- \ uFDCF \ uFDF0- \ uFFEF]������\��������\ d *������\ /������[AZ] | \ d |  -  | \ | _ |?| [\ u00A0- \ uD7FF \ uF900- \ uFDCF \ uFDF0- \ uFFEF]��|����[\ DA-F] {2}��| [��
}��$ .validator.messages.url��;

/ **
 *���ֵ����Ч�ĳ���ʶ��ţ�VIN�����򷵻�true��
 *
 *�������������͵��ı����롣
 *
 * @example <input type =��text��size =��20��name =��VehicleID��class =��{required��true��vinUS��true}��/>
 * @desc�������������Ԫ�أ���ֵ��������Ч�ĳ���ʶ��š�
 *
 * @name $ .validator.methods.vinUS
 * @type����ֵ
 * @cat���/��֤/����
 * /
$ .validator.addMethod����vinUS����function��v��{
	if��v.length��== 17��{
		�������;
	}

	var LL = [��A������B������C������D������E������F������G������H������J������K������L������M ������N������P������R������S������T������U������V������W������X������Y������Z��]��
		VL = [1,2,3,4,5,6,7,8,1,2,3,4,5,7,9,2,3,4,5,6,7,8,9]��
		FL = [8,7,6,5,4,3,2,10,0,9,8,7,6,5,4,3,2]��
		rs = 0��
		i��n��d��f��cd��cdv;

	for��i = 0; i <17; i ++��{
		f = FL [i];
		d = v.slice��i��i + 1��;
		if��i === 8��{
			cdv = d;
		}
		if����isNaN��d����{
			d * = f;
		} else {
			for��n = 0; n <LL.length; n ++��{
				if��d.toUpperCase����=== LL [n]��{
					d = VL [n];
					d * = f;
					if��isNaN��cdv��&& n === 8��{
						cdv = LL [n];
					}
					����;
				}
			}
		}
		rs + = d;
	}
	cd = rs��11;
	if��cd === 10��{
		cd =��X��;
	}
	if��cd === cdv��{
		����true;
	}
	�������;
}����ָ���ĳ���ʶ��ţ�VIN����Ч���� ��;

$ .validator.addMethod����zipcodeUS����function��value��element��{
	����this.optional��Ԫ�أ�|| / ^ \ d {5}�� -  \ d {4}����$ / .test��value��;
}����ָ������������������Ч����;

$ .validator.addMethod����ziprange����function��value��element��{
	����this.optional��Ԫ�أ�|| / ^ 90 [2-5] \ d \ {2 \}  -  \ d {4} $ / .test��value��;
}���������������������902xx-xxxx��905xx-xxxx��Χ�ڡ�;
����$;
}����;