//
//  Date+convenient.swift
//  LYCategory
//
//  Created by 孙宁宁 on 2022/9/28.
//

import YYCategories

extension Date {
    
    public var ly_asNS: NSDate {return self as NSDate}
    
    public var ly_year: Int { return ly_asNS.year}
    public var ly_month: Int { return ly_asNS.month}
    public var ly_day: Int { return ly_asNS.day}
    public var ly_hour: Int { return ly_asNS.hour}
    public var ly_minute: Int { return ly_asNS.minute}
    public var ly_second: Int { return ly_asNS.second}
    public var ly_nanosecond: Int { return ly_asNS.nanosecond}
    public var ly_weekday: Int { return ly_asNS.weekday}
    
    
    public var ly_weekdayOrdinal: Int { return ly_asNS.weekdayOrdinal}
    public var ly_weekOfMonth: Int { return ly_asNS.weekOfMonth}    // WeekOfMonth component (1~5)
    public var ly_weekOfYear: Int { return ly_asNS.weekOfYear}      //WeekOfYear component (1~53)
    public var ly_quarter: Int { return ly_asNS.quarter}
    public var ly_isLeapMonth: Bool { return ly_asNS.isLeapMonth}
    public var ly_isLeapYear: Bool { return ly_asNS.isLeapYear }
    public var ly_isToday: Bool { return ly_asNS.isToday}
    public var ly_isYesterday: Bool { return ly_asNS.isYesterday }
    

    
    /// 返回一个新时间，如果失败（应该没有失败的可能性）就返回 Date(timeIntervalSince1970: 0)
    /// - Parameters:
    ///   - years:
    ///   - months:
    ///   - weeks:
    ///   - days:
    ///   - hours:
    ///   - minutes:
    ///   - seconds:
    /// - Returns: Date
    public func ly_add(
        years: Int = 0,
        months: Int = 0,
        weeks: Int = 0,
        days: Int = 0,
        hours: Int = 0,
        minutes: Int = 0,
        seconds: Int = 0) -> Date {
            var rs: NSDate? = ly_asNS
            if years != 0 { rs = rs?.addingYears(years) as? NSDate }
            if months != 0 { rs = rs?.addingMonths(months) as? NSDate }
            if weeks != 0 { rs = rs?.addingWeeks(weeks) as? NSDate }
            if days != 0 { rs = rs?.addingDays(days) as? NSDate }
            if minutes != 0 { rs = rs?.addingMinutes(minutes) as? NSDate }
            if seconds != 0 { rs = rs?.addingSeconds(seconds) as? NSDate }
            
            guard let rs1 = rs as? Date else { return Date(timeIntervalSince1970: 0) }
            return rs1
        }
    
    
    
    /// 时间转字符串 默认是手机
    /// let americanTimeZone = TimeZone(identifier: "America/Chicago")
    /// let locale = Locale(identifier: "ff_Latn_SL")
    /// let rs = Date().ly_formatString(
    ///         format: "yyyy-MM-dd HH:mm:ss a",
    ///         timeZone: americanTimeZone,
    ///         locale: locale
    ///         )!
    /// print("this is \(rs)") 得到结果：  this is 2022-09-28 00:04:09 subaka
    /// 如果locale用美国的，就会得到 this is 2022-09-28 00:04:09 AM
    /// locale 是这个字符串按照什么地区的写法来显示、
    /// timeZone 是计算这个timeZone下是几点 因为date表示的是一个时间点，这个时间点在不同时区的表达不一样
    
    /// - Parameter format:  format 格式参考：http://www.unicode.org/reports/tr35/tr35-31/tr35-dates.html#Date_Format_Patterns
    /// - Returns: 如果格式错了，返回nil
    public func ly_formatString(
        format: String = "yyyy-MM-dd HH:mm:ss",
        timeZone: TimeZone? = nil,
        locale: Locale? = nil) -> String? {
            return ly_asNS.string(withFormat: format, timeZone: timeZone, locale: locale)
    }
}

extension String {
    
    public func ly_date(
        format: String = "yyyy-MM-dd HH:mm:ss",
        timeZone: TimeZone? = nil,
        locale: Locale? = nil
    ) -> Date? {
        return NSDate(string: self, format: format, timeZone: timeZone, locale: locale) as? Date
    }
    
}


//@property (nonatomic, readonly) NSInteger year; ///< Year component
//@property (nonatomic, readonly) NSInteger month; ///< Month component (1~12)
//@property (nonatomic, readonly) NSInteger day; ///< Day component (1~31)
//@property (nonatomic, readonly) NSInteger hour; ///< Hour component (0~23)
//@property (nonatomic, readonly) NSInteger minute; ///< Minute component (0~59)
//@property (nonatomic, readonly) NSInteger second; ///< Second component (0~59)
//@property (nonatomic, readonly) NSInteger nanosecond; ///< Nanosecond component
//@property (nonatomic, readonly) NSInteger weekday; ///< Weekday component (1~7, first day is based on user setting)
//@property (nonatomic, readonly) NSInteger weekdayOrdinal; ///< WeekdayOrdinal component
//@property (nonatomic, readonly) NSInteger weekOfMonth; ///< WeekOfMonth component (1~5)
//@property (nonatomic, readonly) NSInteger weekOfYear; ///< WeekOfYear component (1~53)
//@property (nonatomic, readonly) NSInteger yearForWeekOfYear; ///< YearForWeekOfYear component
//@property (nonatomic, readonly) NSInteger quarter; ///< Quarter component
//@property (nonatomic, readonly) BOOL isLeapMonth; ///< Weather the month is leap month
//@property (nonatomic, readonly) BOOL isLeapYear; ///< Weather the year is leap year
//@property (nonatomic, readonly) BOOL isToday; ///< Weather date is today (based on current locale)
//@property (nonatomic, readonly) BOOL isYesterday; ///< Weather date is yesterday (based on current locale)
//
//#pragma mark - Date modify
/////=============================================================================
///// @name Date modify
/////=============================================================================
//
///**
// Returns a date representing the receiver date shifted later by the provided number of years.
// 
// @param years  Number of years to add.
// @return Date modified by the number of desired years.
// */
//- (nullable NSDate *)dateByAddingYears:(NSInteger)years;
//
///**
// Returns a date representing the receiver date shifted later by the provided number of months.
// 
// @param months  Number of months to add.
// @return Date modified by the number of desired months.
// */
//- (nullable NSDate *)dateByAddingMonths:(NSInteger)months;
//
///**
// Returns a date representing the receiver date shifted later by the provided number of weeks.
// 
// @param weeks  Number of weeks to add.
// @return Date modified by the number of desired weeks.
// */
//- (nullable NSDate *)dateByAddingWeeks:(NSInteger)weeks;
//
///**
// Returns a date representing the receiver date shifted later by the provided number of days.
// 
// @param days  Number of days to add.
// @return Date modified by the number of desired days.
// */
//- (nullable NSDate *)dateByAddingDays:(NSInteger)days;
//
///**
// Returns a date representing the receiver date shifted later by the provided number of hours.
// 
// @param hours  Number of hours to add.
// @return Date modified by the number of desired hours.
// */
//- (nullable NSDate *)dateByAddingHours:(NSInteger)hours;
//
///**
// Returns a date representing the receiver date shifted later by the provided number of minutes.
// 
// @param minutes  Number of minutes to add.
// @return Date modified by the number of desired minutes.
// */
//- (nullable NSDate *)dateByAddingMinutes:(NSInteger)minutes;
//
///**
// Returns a date representing the receiver date shifted later by the provided number of seconds.
// 
// @param seconds  Number of seconds to add.
// @return Date modified by the number of desired seconds.
// */
//- (nullable NSDate *)dateByAddingSeconds:(NSInteger)seconds;
//
//
//#pragma mark - Date Format
/////=============================================================================
///// @name Date Format
/////=============================================================================
//
///**
// Returns a formatted string representing this date.
// see http://www.unicode.org/reports/tr35/tr35-31/tr35-dates.html#Date_Format_Patterns
// for format description.
// 
// @param format   String representing the desired date format.
// e.g. @"yyyy-MM-dd HH:mm:ss"
// 
// @return NSString representing the formatted date string.
// */
//- (nullable NSString *)stringWithFormat:(NSString *)format;
//
///**
// Returns a formatted string representing this date.
// see http://www.unicode.org/reports/tr35/tr35-31/tr35-dates.html#Date_Format_Patterns
// for format description.
// 
// @param format    String representing the desired date format.
// e.g. @"yyyy-MM-dd HH:mm:ss"
// 
// @param timeZone  Desired time zone.
// 
// @param locale    Desired locale.
// 
// @return NSString representing the formatted date string.
// */
//- (nullable NSString *)stringWithFormat:(NSString *)format
//                               timeZone:(nullable NSTimeZone *)timeZone
//                                 locale:(nullable NSLocale *)locale;
//
///**
// Returns a string representing this date in ISO8601 format.
// e.g. "2010-07-09T16:13:30+12:00"
// 
// @return NSString representing the formatted date string in ISO8601.
// */
//- (nullable NSString *)stringWithISOFormat;
//
///**
// Returns a date parsed from given string interpreted using the format.
// 
// @param dateString The string to parse.
// @param format     The string's date format.
// 
// @return A date representation of string interpreted using the format.
// If can not parse the string, returns nil.
// */
//+ (nullable NSDate *)dateWithString:(NSString *)dateString format:(NSString *)format;
//
///**
// Returns a date parsed from given string interpreted using the format.
// 
// @param dateString The string to parse.
// @param format     The string's date format.
// @param timeZone   The time zone, can be nil.
// @param locale     The locale, can be nil.
// 
// @return A date representation of string interpreted using the format.
// If can not parse the string, returns nil.
// */
//+ (nullable NSDate *)dateWithString:(NSString *)dateString
//                             format:(NSString *)format
//                           timeZone:(nullable NSTimeZone *)timeZone
//                             locale:(nullable NSLocale *)locale;
//
///**
// Returns a date parsed from given string interpreted using the ISO8601 format.
// 
// @param dateString The date string in ISO8601 format. e.g. "2010-07-09T16:13:30+12:00"
// 
// @return A date representation of string interpreted using the format.
// If can not parse the string, returns nil.
// */
//+ (nullable NSDate *)dateWithISOFormatString:(NSString *)dateString;
