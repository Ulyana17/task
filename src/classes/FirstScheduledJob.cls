global with sharing class FirstScheduledJob implements Schedulable {
    public static String CRON_EXP = '* 0 * * * ?';

    global void execute(SchedulableContext ctx) {
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime
        FROM CronTrigger WHERE Id = :ctx.getTriggerId()];

        ID firstBatchProcessId = Database.executeBatch(new FirstBatchJob());
        ID secondBatchProcessId = Database.executeBatch(new SecondBatchJob());
    }
}