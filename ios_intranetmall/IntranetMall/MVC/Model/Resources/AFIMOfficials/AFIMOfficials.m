//
//  AFIMOfficials.m
//  IntranetMall
//
//  Created by Fabrício Masiero on 29/11/16.
//  Copyright © 2016 Fabrício Masiero. All rights reserved.
//

#import "AFIMOfficials.h"
#import "AFDatabaseManager.h"


@implementation AFIMOfficials

- (id)initWithDictionary:(NSDictionary *)dictionary {
    if (self) {
        NSDictionary *officialDic = dictionary;
//        if ([dictionary containsKey:@"cadastro_funcionario"]) {
////            NSDictionary *officialDic = dictionary[@"cadastro_funcionario"];
//            
//            if ([officialDic isKindOfClass:[NSArray class]]) {
//                NSArray *of = (NSArray *)officialDic;
//                officialDic = of[0];
//            }
        
        if ([officialDic containsKey:@"idcad"]) {
            _officialId = [self getNumberValue:officialDic[@"idcad"]];
        }
        
        if ([officialDic containsKey:@"bairro"]) {
            _neighborhood = [self getValue:officialDic[@"bairro"]];
        }
        
        if ([officialDic containsKey:@"cargo_lojista"]) {
            _officialRole = [self getValue:officialDic[@"cargo_lojista"]];
        }
        
        if ([officialDic containsKey:@"cep"]) {
            _postalCode = [self getValue:officialDic[@"cep"]];
        }
        
        if ([officialDic containsKey:@"cidade"]) {
            _city = [self getValue:officialDic[@"cidade"]];
        }
        
        if ([officialDic containsKey:@"codfoto"]) {
            _photoName = [self getValue:officialDic[@"codfoto"]];
        }
        
        if ([officialDic containsKey:@"compl"]) {
            _complement = [self getValue:officialDic[@"compl"]];
        }
        
        if ([officialDic containsKey:@"cor"]) {
            _color = [self getValue:officialDic[@"cor"]];
        }
        
        if ([officialDic containsKey:@"cpf"]) {
            _documentIdentifier = [self getValue:officialDic[@"cpf"]];
        }
        
        if ([officialDic containsKey:@"dataAdm"]) {
            _adminDate = [self getDateValue:officialDic[@"dataAdm"]];
        }
        
        if ([officialDic containsKey:@"dataDemissao"]) {
            _resignationDate = [self getDateValue:officialDic[@"dataDemissao"]];
        }
        
        if ([officialDic containsKey:@"dataNasc"]) {
            _birthDate = [self getDateValue:officialDic[@"dataNasc"]];
        }
        
        if ([officialDic containsKey:@"datacad"]) {
            _registerDate = [self getDateValue:officialDic[@"datacad"]];
        }
        
        if ([officialDic containsKey:@"descricaoCracha"]) {
            _badgeDescription = [self getValue:officialDic[@"descricaoCracha"]];
        }
        
        if ([officialDic containsKey:@"endereco"]) {
            _address = [self getValue:officialDic[@"endereco"]];
        }
        
        if ([officialDic containsKey:@"filiacao_mae"]) {
            _momFiliation = [self getValue:officialDic[@"filiacao_mae"]];
        }
        
        if ([officialDic containsKey:@"filiacao_pai"]) {
            _dadFilitation = [self getValue:officialDic[@"filiacao_pai"]];
        }
        
        if ([officialDic containsKey:@"idUser"]) {
            _userId = [self getNumberValue:officialDic[@"idUser"]];
        }
        
        if ([officialDic containsKey:@"idcad"]) {
            _registerId = [self getNumberValue:officialDic[@"idcad"]];
        }
        
        if ([officialDic containsKey:@"imagem"]) {
            _imgBase64 = [self getValue:officialDic[@"imagem"]];
        }
        
        if ([officialDic containsKey:@"loja_luc"]) {
            _storeLuc = [self getNumberValue:officialDic[@"loja_luc"]];
        }
        
        if ([officialDic containsKey:@"loja_nome"]) {
            _storeName = [self getValue:officialDic[@"loja_nome"]];
        }
        
        if ([officialDic containsKey:@"marca"]) {
            _brand = [self getValue:officialDic[@"marca"]];
        }
        
        if ([officialDic containsKey:@"modelo"]) {
            _model = [self getValue:officialDic[@"modelo"]];
        }
        
        if ([officialDic containsKey:@"naturalidade"]) {
            _naturalness = [self getValue:officialDic[@"naturalidade"]];
        }
        
        if ([officialDic containsKey:@"nome_lojista"]) {
            _shopkeeperName = [self getValue:officialDic[@"nome_lojista"]];
        }
        
        if ([officialDic containsKey:@"numero"]) {
            _number = [self getValue:officialDic[@"numero"]];
        }
        
        if ([officialDic containsKey:@"placa"]) {
            _plate = [self getValue:officialDic[@"placa"]];
        }
        
        if ([officialDic containsKey:@"rg"]) {
            _documentInsideCountry = [self getValue:officialDic[@"rg"]];
        }
        
        if ([officialDic containsKey:@"sexo"]) {
            _sexuality = [self getValue:officialDic[@"sexo"]];
        }
        
        if ([officialDic containsKey:@"status_cad"]) {
            _registerStatus = [self getNumberValue:officialDic[@"status_cad"]];
        }
        
        if ([officialDic containsKey:@"telefone"]) {
            _phone = [self getValue:officialDic[@"telefone"]];
        }
        
        if ([officialDic containsKey:@"uf"]) {
            _state = [self getValue:officialDic[@"uf"]];
        }
        
        if ([officialDic containsKey:@"validade"]) {
            _validateDate = [self getDateValue:officialDic[@"validade"]];
        }
        _synced = YES;
        [[AFDatabaseManager sharedManager] createOfficial:self];
        
        //        }
    }
    return self;
}

- (NSString *)getValue:(NSDictionary *)dic {
    if ([dic containsKey:@"text"]) {
        return [NSString stringWithFormat:@"%@", dic[@"text"]];
    } else {
        return @"";
    }
}
- (NSNumber *)getNumberValue:(NSDictionary *)dic {
    return @([[self getValue:dic] integerValue]);
}

- (NSDate *)getDateValue:(NSDictionary *)dic {
    NSString *value = [self getValue:dic];
    return [NSDate dateFromString:value];
}

- (NSString *)getRegisterStatusValue {
    switch (self.registerStatus.integerValue) {
        case 0:
            return @"Não sei valor";
            break;
        case 1:
            return @"Novo Cadastro";
            break;
        case 2:
            return @"Aguardando aprovação do Depto. de Segurança";
            break;
        case 3:
            return @"Foto fora do padrão.Reenviar";
            break;
        case 4:
            return @"Crachá na ADM. Aguardando retirada";
            break;
        case 5:
            return @"Funcionário Ativo";
            break;
        case 6:
            return @"Funcionário Inativo";
            break;
        case 7:
            return @"Aprovado. Aguardando emissão do Crachá.";
            break;
        case 8:
            return @"Cadastro reprovado pelo Depto. de Segurança";
            break;
        case 9:
            return @"Crachá em emissão";
            break;
            
        default:
            return @"Default Valor";
            break;
    }
}

+ (void)getOfficialsWithUserId:(NSNumber *)userId shoppingId:(NSNumber *)shoppingId andCompletion:(void (^)(NSArray *officialList))completion failure:(void (^)(NSError *error))failure {
    NSArray *param = @[@{AFSOAPRequestNameKey: @"idUser", AFSOAPRequestValueKey: userId},
                       @{AFSOAPRequestNameKey: @"idShopping", AFSOAPRequestValueKey: shoppingId}];
    
    [[AFSoapAPIClient sharedClient] soapRequestWithPath:@"DetalheFuncionario" withParameters:param andCompletion:^(id response) {
        NSMutableArray *mutableResp = [[NSMutableArray alloc] init];
        if ([response count] > 0) {
            NSArray *resp = response[@"cadastro_funcionario"];
            
            for (NSDictionary *d in resp) {
                [mutableResp addObject:[[AFIMOfficials alloc] initWithDictionary:d]];
            }
        }
        NSArray *allOfficials = [Official all];
        completion(allOfficials);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

+ (void)saveOfficial:(NSDictionary *)dic user:(AFIMUser *)u andCompletion:(void (^)(NSInteger officialId))completion failure:(void (^)(NSError *error))failure {
    
    NSNumber *registerStatus = 0;
    if ([dic containsKey:@"registerStatus"]) {
        registerStatus = @([dic[@"registerStatus"] integerValue]);
    } else {
        registerStatus = @(1);
    }
    
    NSArray *param = @[@{AFSOAPRequestNameKey: @"idShopping", AFSOAPRequestValueKey: u.shoppingId},
                       @{AFSOAPRequestNameKey: @"iduser", AFSOAPRequestValueKey: u.userId},
                       @{AFSOAPRequestNameKey: @"idCad", AFSOAPRequestValueKey: dic[@"officialId"]},
                       @{AFSOAPRequestNameKey: @"status_cad", AFSOAPRequestValueKey: registerStatus},
                       @{AFSOAPRequestNameKey: @"data_adm", AFSOAPRequestValueKey: dic[@"registerDate"]},
                       @{AFSOAPRequestNameKey: @"nome_lojista", AFSOAPRequestValueKey: dic[@"shopkeeperName"]},
                       @{AFSOAPRequestNameKey: @"data_dem", AFSOAPRequestValueKey: dic[@"resignationDate"]},
                       @{AFSOAPRequestNameKey: @"cargo_lojista", AFSOAPRequestValueKey: dic[@"officialRole"]},
                       @{AFSOAPRequestNameKey: @"telefone", AFSOAPRequestValueKey: dic[@"phone"]},
                       @{AFSOAPRequestNameKey: @"rg", AFSOAPRequestValueKey: [dic[@"documentInsideCountry"] prepareToCheck]},
                       @{AFSOAPRequestNameKey: @"cpf", AFSOAPRequestValueKey: [dic[@"documentIdentifier"] prepareToCheck]},
                       @{AFSOAPRequestNameKey: @"filiacao_pai", AFSOAPRequestValueKey: dic[@"dadFilitation"]},
                       @{AFSOAPRequestNameKey: @"datanasc", AFSOAPRequestValueKey: dic[@"birthDate"]},
                       @{AFSOAPRequestNameKey: @"filiacao_mae", AFSOAPRequestValueKey: dic[@"momFiliation"]},
                       @{AFSOAPRequestNameKey: @"naturalidade", AFSOAPRequestValueKey: dic[@"naturalness"]},
                       @{AFSOAPRequestNameKey: @"endereco", AFSOAPRequestValueKey: dic[@"address"]},
                       @{AFSOAPRequestNameKey: @"numero", AFSOAPRequestValueKey: dic[@"number"]},
                       @{AFSOAPRequestNameKey: @"compl", AFSOAPRequestValueKey: dic[@"complement"]},
                       @{AFSOAPRequestNameKey: @"bairro", AFSOAPRequestValueKey: dic[@"neighborhood"]},
                       @{AFSOAPRequestNameKey: @"cep", AFSOAPRequestValueKey: [dic[@"postalCode"] prepareToCheck]},
                       @{AFSOAPRequestNameKey: @"cidade", AFSOAPRequestValueKey: dic[@"city"]},
                       @{AFSOAPRequestNameKey: @"uf", AFSOAPRequestValueKey: dic[@"state"]},
                       @{AFSOAPRequestNameKey: @"sexo", AFSOAPRequestValueKey: dic[@"sexuality"]},
                       @{AFSOAPRequestNameKey: @"validade", AFSOAPRequestValueKey: @"0"},
                       @{AFSOAPRequestNameKey: @"modelo", AFSOAPRequestValueKey: @"0"},
                       @{AFSOAPRequestNameKey: @"marca", AFSOAPRequestValueKey: @"0"},
                       @{AFSOAPRequestNameKey: @"cor", AFSOAPRequestValueKey: @"0"},
                       @{AFSOAPRequestNameKey: @"placa", AFSOAPRequestValueKey: @"0"},
                       @{AFSOAPRequestNameKey: @"imagem", AFSOAPRequestValueKey: dic[@"imgBase64"]},
                       @{AFSOAPRequestNameKey: @"status_cad", AFSOAPRequestValueKey: @(1)}];
    
    [[AFSoapAPIClient sharedClient] soapRequestWithPath:@"GravaFuncionario" withParameters:param andCompletion:^(id response) {
        NSDictionary *resp = [response[@"cadastro_funcionario"] objectForKey:@"retorno"];
        if ([[resp allKeys] count] > 0) {
            NSLog(@"response");
            NSInteger officialId = [resp[@"text"] integerValue];
            completion(officialId);
        } else {
            NSMutableDictionary *details = [NSMutableDictionary dictionary];
            [details setValue:@"Ocorreu um erro. A API retornou uma resposta vazia!" forKey:NSLocalizedDescriptionKey];
            NSError *error = [NSError errorWithDomain:@"Error" code:200 userInfo:details];
            failure(error);
            NSLog(@"not response");
        }
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}

@end
