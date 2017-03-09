# MoonCacheManager
---
MoonCacheManager is a tool to help you save object into sqlite and retrieve object simply.

##prepaire to work##
before you work with MoonCacheManager,the class of objects you want to save and retrieve must implement
the class function IndexKey that define in MoonDiskCacheProtocol to idnetify a object in disk.for example:

```Objective-C
+(NSString *)indexKey{
    return @"sID";
}
```

## simple CURD ##

### save ###

save operation include create and update object,when indexKey is exist in disk will execute update operation, or execute create operation. you can save object like follow:

```Objective-C
NSError *error = nil;
[MoonCacheManager saveWithSqlMaker:^(MoonSqlSaveMaker *maker) {
        maker.save(student);
    } andError:&error];
```

### delete ###

delete opearation will delete objects in disk.when you want to delete object of one type,you can do like this:

```Objective-C
NSError *error = nil;
[MoonCacheManager deleteWithSqlMaker:^(MoonSqlDeleteMaker *maker) {
        maker.deleteClass([student class]);
    } andError:&error];    
```

when you want to delete an object,you can do like follow:

```Objective-C
NSError *error = nil;
[MoonCacheManager deleteWithSqlMaker:^(MoonSqlDeleteMaker *maker) {
        maker.deleteObj(student);
    } andError:&error];
```

or you can use delete class with special condition like follow

```Objective-C
NSError *error = nil;
[MoonCacheManager deleteWithSqlMaker:^(MoonSqlDeleteMaker *maker) {
        maker.deleteClass([StudentModel class]).where([NSString stringWithFormat:@"condition='%@'",@"condition"]);
    } andError:&error];
```

### query ###

when you want to execute query operation,you must give the type you want query,you can also use some optional condition to make reuslt more accurate.

```Objective-C
NSError *error = nil;
NSArray *result = [MoonCacheManager queryWithSqlMaker:^(MoonSqlQueryMaker *maker) {
        maker.query([StudentModel class]).where([NSString stringWithFormat:@"condition='%@'",@"condition"]).orderBy(@"OrderItem",MoonSqlMakerOrderTypeDESC).limit(1,10);
    } andError:&error];
```



