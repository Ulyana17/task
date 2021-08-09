global with sharing class SecondScheduledClass  implements Schedulable {
    public static String CRON_EXP = '* 30 * * * ?';

    global void execute(SchedulableContext ctx) {
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime
        FROM CronTrigger WHERE Id = :ctx.getTriggerId()];

        ID firstBatchProcessId = Database.executeBatch(new FirstBatchJob());
        ID secondBatchProcessId = Database.executeBatch(new SecondBatchJob());
    }
}