import dateutil
import dateutil.relativedelta
import dateutil.rrule
import datetime

import grok
from cashpad.app import App, User
from cashpad.browser import resource

grok.templatedir('templates')
class Index(grok.View):
    grok.context(App)

    def update(self):
        resource.style.need()
        resource.custom_js.need()

class Login(grok.View):
    grok.context(App)

    def update(self):
        resource.style.need()
        resource.custom_js.need()

class UserIndex(grok.View):
    grok.context(User)
    grok.name('index')

    def update(self):
        resource.style.need()
        resource.custom_js.need()

        today = datetime.date.today()
        previous_monday = today + dateutil.relativedelta.relativedelta(
            weekday=dateutil.relativedelta.MO(-1))

        week = [day.date() for day in dateutil.rrule.rrule(
            dateutil.rrule.DAILY, count=7, dtstart=previous_monday)]
        days = dict([(k, dict(revenue=0)) for k in week])
        # XXX not efficient, move to model code, use catalog.
        for order in self.context['order'].values():
            day = order.created_on.date()
            # We are only interested in this week's data:
            # We assume that no orders with future datetimes have been made.
            if day not in week:
                continue
            days[day]['revenue'] += order.total_price

        self.days = [dict(day=day, data=data) for day, data in sorted(days.items())]
