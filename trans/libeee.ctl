//#CTL2
// v1.0
// v1.1 - Correção no comando de "trim" das transformações da função formatDecimal.
// v1.2 - Adicionada função "formatKey" para tratamento de chaves primárias.

string GOODDATA_DEMOMODE = upperCase('${DEMO}');
double GOODDATA_MAXVALUE = str2double('${NUMBER_MAXSIZE}', '${NUMBER_PATTERN}','${NUMBER_LOCALE}');
date   GOODDATA_MINDATE = str2date('${GOODDATA_MINDATE}', 'yyyy-MM-dd');
date   GOODDATA_MAXDATE = str2date('${GOODDATA_MAXDATE}', 'yyyy-MM-dd');
date   data;

// Função de tratamento de campos tipo decimal.
function decimal formatDecimal(string  format) {
    if((format == null) or (trim(format) == '')) {
        return 0;
    } else {
        if(abs(str2decimal(trim(format), '${NUMBER_PATTERN}','${NUMBER_LOCALE}')) >= GOODDATA_MAXVALUE) {
            return 0;
        } else {
            if (GOODDATA_DEMOMODE == 'S') {
                return random()*str2decimal(trim(format), '${NUMBER_PATTERN}','${NUMBER_LOCALE}');
            } else {
                return str2decimal(trim(format), '${NUMBER_PATTERN}','${NUMBER_LOCALE}');
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
            return translate(trim(upperCase(removeNonPrintable(format))), 'ÁÉÍÓÚÀÈÌÒÙÄËÏÖÜÂÊÎÔÛÃÕ', 'AEIOUAEIOUAEIOUAEIOUAO');
        }
    }
}

// Função de tratamento de campos tipo string.
function string formatKey(string format) {
    if((format == null) or (trim(format) == '')) {
        return 'N/A';
    } else {
        return format;
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