//#CTL2

string GOODDATA_DEMOMODE = upperCase('${DEMO}');
double GOODDATA_MAXVALUE = str2double('${NUMBER_MAXSIZE}', '${NUMBER_PATTERN}','${NUMBER_LOCALE}');
date   GOODDATA_MINDATE = str2date('${GOODDATA_MINDATE}', 'yyyy-MM-dd');
date   GOODDATA_MAXDATE = str2date('${GOODDATA_MAXDATE}', 'yyyy-MM-dd');
date   data;
string TipoPessoa;

//Agora sim ctz q vai!!!!!!...!

// Função de tratamento de campos tipo decimal.
function decimal formatDecimal(string  format) {
    if((format == null) or (trim(format) == '')) {
        return 0;
    } else {
        if(str2decimal(trim(format), '${NUMBER_PATTERN}','${NUMBER_LOCALE}') >= GOODDATA_MAXVALUE) {
            return 0;
        } else {
            if (GOODDATA_DEMOMODE == 'S') {
                return random()*str2decimal(format, '${NUMBER_PATTERN}','${NUMBER_LOCALE}');
            } else {
                return str2decimal(format, '${NUMBER_PATTERN}','${NUMBER_LOCALE}');
            }
        }
    }
}

// Função de tratamento de campos tipo long.
function long formatLong(string  format) {
    if((format == null) or (trim(format) == '')) {
        return 0;
    } else {
        if(abs(str2long(trim(format), '${NUMBER_PATTERN}','${NUMBER_LOCALE}')) >= GOODDATA_MAXVALUE) {
            return 0;
        } else {
            if (GOODDATA_DEMOMODE == 'S') {
                return round(random()*str2long(format, '${NUMBER_PATTERN}','${NUMBER_LOCALE}'));
            } else {
                return str2long(format, '${NUMBER_PATTERN}','${NUMBER_LOCALE}');
            }
        }
    }
}

// Função de tratamento de campos tipo string.
function string formatString(string format, string demoValue) {
    if((format == null) or (trim(format) == '')) {
        return 'N/A';
    } else {
        if ((GOODDATA_DEMOMODE == 'S') and (demoValue <> null)) {
            return demoValue;
        } else {
            return removeNonPrintable(translate(trim(upperCase(format)), 'ÁÉÍÓÚÀÈÌÒÙÄËÏÖÜÂÊÎÔÛÃÕÑÇ', 'AEIOUAEIOUAEIOUAEIOUAONC'));
        }
    }
}

// Função de tratamento de campos tipo date.
function date formatDate(string format) {
    if((format == null) or (trim(format) == '')) {
        return null;
    } else {
        data = str2date(format, '${DATE_PATTERN}', '${DATE_LOCALE}');
        if ((data < GOODDATA_MINDATE) || (data > GOODDATA_MAXDATE)) {
            return null;
        } else {
            return data;
        }
    }
}

//Função para calcular a diferença entre duas datas.
//valor1 - Valor da primeira data em String.
//valor2 - Valor da segunda data em String.
function decimal formatDate2(string valor1, string valor2) {
    if(((valor1 == null) or (trim(valor1) == '')) or ((valor2 == null) or (trim(valor2) == ''))) {
        return 0.0;
    } else {
        date data1 = str2date(valor1, "yyyyMMdd HH:mm:ss", '${DATE_LOCALE}');
        date data2 = str2date(valor2, "yyyyMMdd HH:mm:ss", '${DATE_LOCALE}');
        
        if (((data1 < GOODDATA_MINDATE) || (data1 > GOODDATA_MAXDATE)) or ((data2 < GOODDATA_MINDATE) || (data2 > GOODDATA_MAXDATE))) {
            return 0.0;
        } else {
            return dateDiff(data1,data2,minute);
        }
    }
}

// Função de tratamento esclusivo RM de campos tipo string.
function string formatKey(string coligada, string codigo) {
    if(((coligada == null) or (trim(coligada) == '')) or ((codigo == null) or (trim(codigo) == ''))) {
        return '${INSTANCIA}' + '|INDEFINIDO';
    } else {
        return '${INSTANCIA}' + '|' + coligada + '|' + codigo;
    }
}
