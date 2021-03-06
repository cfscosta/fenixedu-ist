/**
 * Copyright © 2013 Instituto Superior Técnico
 *
 * This file is part of FenixEdu IST Vigilancies.
 *
 * FenixEdu IST Vigilancies is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * FenixEdu IST Vigilancies is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with FenixEdu IST Vigilancies.  If not, see <http://www.gnu.org/licenses/>.
 */
package pt.ist.fenixedu.vigilancies.service;

import java.util.Collections;
import java.util.List;

import org.fenixedu.academic.domain.ExecutionYear;
import org.fenixedu.academic.domain.Person;
import org.fenixedu.academic.domain.util.email.ConcreteReplyTo;
import org.fenixedu.academic.domain.util.email.Message;
import org.fenixedu.academic.domain.util.email.Sender;
import org.fenixedu.bennu.core.domain.Bennu;
import org.fenixedu.bennu.core.i18n.BundleUtil;
import org.joda.time.DateTime;

import pt.ist.fenixedu.vigilancies.domain.UnavailablePeriod;
import pt.ist.fenixedu.vigilancies.domain.VigilantGroup;
import pt.ist.fenixframework.Atomic;

public class CreateUnavailablePeriod {

    @Atomic
    public static void run(Person person, DateTime begin, DateTime end, String justification) {

        CreateUnavailable(person, begin, end, justification);
        sendEmail(person, begin, end, justification,
                VigilantGroup.getVigilantGroupsForExecutionYear(person, ExecutionYear.readCurrentExecutionYear()));
    }

    private static void CreateUnavailable(Person person, DateTime begin, DateTime end, String justification) {
        new UnavailablePeriod(begin, end, justification, person);
    }

    private static void sendEmail(Person person, DateTime begin, DateTime end, String justification, List<VigilantGroup> groups) {
        for (VigilantGroup group : groups) {
            String bccs = group.getContactEmail();

            String beginDate =
                    begin.getDayOfMonth() + "/" + begin.getMonthOfYear() + "/" + begin.getYear() + " - "
                            + String.format("%02d", begin.getHourOfDay()) + ":" + String.format("%02d", begin.getMinuteOfHour())
                            + "h";
            String endDate =
                    end.getDayOfMonth() + "/" + end.getMonthOfYear() + "/" + end.getYear() + " - "
                            + String.format("%02d", end.getHourOfDay()) + ":" + String.format("%02d", end.getMinuteOfHour())
                            + "h";;
            String message =
                    BundleUtil.getString("resources.VigilancyResources", "email.convoke.unavailablePeriod",
                            new String[] { person.getName(), beginDate, endDate, justification });

            String subject =
                    BundleUtil.getString("resources.VigilancyResources", "email.convoke.unavailablePeriod.subject",
                            new String[] { group.getName() });

            Sender sender = Bennu.getInstance().getSystemSender();
            new Message(sender, new ConcreteReplyTo(group.getContactEmail()).asCollection(), Collections.EMPTY_LIST, subject,
                    message, bccs);
        }
    }
}