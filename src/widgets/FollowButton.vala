/*  This file is part of Cawbird, a Gtk+ linux Twitter client forked from Corebird.
 *  Copyright (C) 2013 Timm Bäder (Corebird)
 *
 *  Cawbird is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  Cawbird is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with cawbird.  If not, see <http://www.gnu.org/licenses/>.
 */

class FollowButton : Gtk.Button {
  private bool _following = false;
  public bool following {
    get { return _following; }
    set {
      var sc = this.get_style_context ();
      if (value) {
        sc.remove_class ("suggested-action");
        sc.add_class ("destructive-action");
        this.stack.visible_child = unfollow_label;
        get_accessible().set_name(_("Unfollow"));
      } else {
        sc.remove_class ("destructive-action");
        sc.add_class ("suggested-action");
        this.stack.visible_child = follow_label;
        get_accessible().set_name(_("Follow"));
      }
      this._following = value;
    }
  }
  private Gtk.Stack stack;
  private Gtk.Label follow_label;
  private Gtk.Label unfollow_label;
  private bool _compact = false;
  public bool compact {
    get { return _compact; }
    set {
      _compact = value;
      if (_compact) {
        this.follow_label.label = "+";
        this.unfollow_label.label = "-";
      }
      else {
        this.follow_label.label = _("Follow");
        this.unfollow_label.label = _("Unfollow");
      }
    }
  }

  construct {
    this.stack = new Gtk.Stack ();

    this.follow_label = new Gtk.Label (_("Follow"));
    this.unfollow_label = new Gtk.Label (_("Unfollow"));
    this.follow_label.get_accessible().set_name(_("Follow"));
    this.unfollow_label.get_accessible().set_name(_("Unfollow"));

    stack.add (follow_label);
    stack.add (unfollow_label);
    stack.set_interpolate_size (true);
    stack.transition_type = Gtk.StackTransitionType.CROSSFADE;
    stack.hhomogeneous = false;
    stack.vhomogeneous = true;

    this.add (stack);
    this.get_style_context ().add_class ("text-button");
    this.get_style_context ().add_class ("suggested-action"); /* Default is false */
  }

}
